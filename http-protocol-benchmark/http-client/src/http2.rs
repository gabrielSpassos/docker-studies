use reqwest::Client;

pub async fn run() -> Result<(), Box<dyn std::error::Error>> {
    let client = Client::builder()
        .danger_accept_invalid_certs(true)
        .build()?; // let ALPN negotiate HTTP/2

    let res = client
        .get("https://localhost:8443/data")
        .send()
        .await?;

    println!("Version: {:?}", res.version());
    println!("HTTP/2 Status: {}", res.status());
    println!("Body: {}", res.text().await?);

    Ok(())
}