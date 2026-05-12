use std::future::Future;
use std::sync::Arc;
use std::time::{Duration, Instant};

use tokio::sync::Semaphore;

pub async fn run_benchmark<C, F, Fut>(
    client: Arc<C>,
    total_requests: usize,
    concurrency: usize,
    request_fn: F,
)
where
    C: Send + Sync + 'static,
    F: Fn(Arc<C>) -> Fut + Send + Sync + Copy + 'static,
    Fut: Future<Output = Result<(), Box<dyn std::error::Error + Send + Sync>>> + Send,
{
    let semaphore = Arc::new(Semaphore::new(concurrency));

    let mut handles = Vec::new();
    let mut latencies = Vec::new();

    let benchmark_start = Instant::now();

    for _ in 0..total_requests {

        let permit = semaphore.clone().acquire_owned().await.unwrap();

        let client_clone = client.clone();

        let handle = tokio::spawn(async move {

            let request_start = Instant::now();

            let result = request_fn(client_clone).await;

            let latency = request_start.elapsed();

            drop(permit);

            (result, latency)
        });

        handles.push(handle);
    }

    for handle in handles {

        let (result, latency) = handle.await.unwrap();

        if result.is_ok() {
            latencies.push(latency);
        }
    }

    let total_duration = benchmark_start.elapsed();

    latencies.sort();

    let avg_latency = latencies
        .iter()
        .map(|d| d.as_millis())
        .sum::<u128>() as f64
        / latencies.len() as f64;

    let p95 = percentile(&latencies, 95);
    let p99 = percentile(&latencies, 99);

    let rps = total_requests as f64 / total_duration.as_secs_f64();

    println!("=================================");
    println!("Requests: {}", total_requests);
    println!("Concurrency: {}", concurrency);
    println!("Total Duration: {:.2?}", total_duration);
    println!("Requests/sec: {:.2}", rps);
    println!("Average latency: {:.2} ms", avg_latency);
    println!("P95 latency: {} ms", p95.as_millis());
    println!("P99 latency: {} ms", p99.as_millis());
    println!("=================================");
}

fn percentile(latencies: &[Duration], percentile: usize) -> Duration {

    let index = ((latencies.len() as f64)
        * (percentile as f64 / 100.0)) as usize;

    latencies[index.min(latencies.len() - 1)]
}