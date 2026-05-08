use std::sync::Arc;

use quinn::{ClientConfig, Endpoint};
use rustls::{ClientConfig as RustlsClientConfig, RootCertStore};
use h3::client;
use http::Request;

pub async fn run() -> Result<(), Box<dyn std::error::Error>> {
    // ---- TLS (rustls) config ----
    let mut roots = RootCertStore::empty();

    // Accept invalid/self-signed certs (PoC only!)
    let crypto = RustlsClientConfig::builder()
        .with_safe_defaults()
        .with_root_certificates(roots)
        .with_no_client_auth();

    let client_config = ClientConfig::new(Arc::new(crypto));

    // ---- QUIC endpoint ----
    let mut endpoint = Endpoint::client("0.0.0.0:0".parse()?)?;
    endpoint.set_default_client_config(client_config);

    // ---- Connect ----
    let conn = endpoint
        .connect("127.0.0.1:8444".parse()?, "localhost")?
        .await?;

    // ---- HTTP/3 layer ----
    let (mut driver, mut send_request) = client::new(conn).await?;

    // Spawn driver task (required)
    tokio::spawn(async move {
        let _ = driver.await;
    });

    // ---- Request ----
    let req = Request::get("https://localhost:8444/data")
        .body(())?;

    let mut stream = send_request.send_request(req).await?;

    let response = stream.recv_response().await?;
    println!("HTTP/3 Status: {}", response.status());

    Ok(())
}