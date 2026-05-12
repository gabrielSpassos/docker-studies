use std::sync::Arc;

use reqwest::Client;

pub fn create_client() -> Arc<Client> {

    Arc::new(
        Client::builder()
            .danger_accept_invalid_certs(true)
            .build()
            .unwrap()
    )
}

pub async fn request(
    client: Arc<Client>,
) -> Result<(), Box<dyn std::error::Error + Send + Sync>> {

    let response = client
        .get("https://localhost:8443/data")
        .send()
        .await?;

    response.error_for_status()?;

    Ok(())
}