use std::sync::Arc;

use reqwest::Client;

pub fn create_client() -> Arc<Client> {

    Arc::new(
        Client::builder()
            .build()
            .unwrap()
    )
}

pub async fn request(
    client: Arc<Client>,
) -> Result<(), Box<dyn std::error::Error>> {

    let response = client
        .get("http://localhost:8080/data")
        .send()
        .await?;

    response.error_for_status()?;

    Ok(())
}