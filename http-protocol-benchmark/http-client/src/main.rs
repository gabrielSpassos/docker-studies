mod http1;
mod http2;

use std::env;

#[tokio::main]
async fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        eprintln!("Usage: cargo run -- <http1|http2>");
        return;
    }

    let protocol = args[1].as_str();

    let result = match protocol {
        "http1" => http1::run().await,
        "http2" => http2::run().await,
        _ => {
            eprintln!("Invalid option. Use http1 | http2");
            return;
        }
    };

    if let Err(e) = result {
        eprintln!("Error: {}", e);
    }
}