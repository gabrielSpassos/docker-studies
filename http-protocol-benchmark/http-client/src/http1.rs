use reqwest::Client;

pub async fn run() -> Result<(), Box<dyn std::error::Error>> {
    let client = Client::builder()
        .build()?; // default = HTTP/1.1

    let res = client
        .get("http://localhost:8080/data")
        .send()
        .await?;

    println!("HTTP/1.1 Status: {}", res.status());
    println!("Body: {}", res.text().await?);

    Ok(())
}