mod benchmark;
mod http1;
mod http2;

use std::env;

#[tokio::main]
async fn main() {

    let args: Vec<String> = env::args().collect();

    if args.len() != 4 {

        eprintln!(
            "Usage: cargo run -- <http1|http2> <requests> <concurrency>"
        );

        return;
    }

    let protocol = args[1].as_str();

    let requests: usize = args[2].parse().unwrap();

    let concurrency: usize = args[3].parse().unwrap();

    match protocol {

        "http1" => {

            let client = http1::create_client();

            benchmark::run_benchmark(
                client,
                requests,
                concurrency,
                http1::request,
            )
            .await;
        }

        "http2" => {

            let client = http2::create_client();

            benchmark::run_benchmark(
                client,
                requests,
                concurrency,
                http2::request,
            )
            .await;
        }

        _ => {
            eprintln!("Invalid protocol");
        }
    }
}