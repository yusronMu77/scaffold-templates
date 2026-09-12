// {{ .CrateName }} - {{ .Description }}
// Minimal runnable Axum service: one GET / route plus a GET /healthz, no persistence.

use axum::{http::StatusCode, response::IntoResponse, routing::get, Router};

async fn root() -> &'static str {
    "Hello, {{ .CrateName }}!"
}

async fn healthz() -> impl IntoResponse {
    (
        StatusCode::OK,
        [("content-type", "application/json")],
        "{\"status\":\"ok\"}",
    )
}

fn app() -> Router {
    Router::new()
        .route("/", get(root))
        .route("/healthz", get(healthz))
}

#[tokio::main]
async fn main() {
    let listener = tokio::net::TcpListener::bind("0.0.0.0:8080")
        .await
        .unwrap();
    axum::serve(listener, app()).await.unwrap();
}

#[cfg(test)]
mod tests {
    use super::*;
    use axum::body::Body;
    use axum::http::Request;
    use http_body_util::BodyExt;
    use tower::ServiceExt;

    #[tokio::test]
    async fn healthz_returns_ok() {
        let response = app()
            .oneshot(
                Request::builder()
                    .uri("/healthz")
                    .body(Body::empty())
                    .unwrap(),
            )
            .await
            .unwrap();

        assert_eq!(response.status(), StatusCode::OK);
        let body = response.into_body().collect().await.unwrap().to_bytes();
        assert_eq!(&body[..], b"{\"status\":\"ok\"}");
    }

    #[tokio::test]
    async fn root_greets_by_name() {
        let response = app()
            .oneshot(Request::builder().uri("/").body(Body::empty()).unwrap())
            .await
            .unwrap();

        assert_eq!(response.status(), StatusCode::OK);
        let body = response.into_body().collect().await.unwrap().to_bytes();
        assert_eq!(&body[..], b"Hello, {{ .CrateName }}!");
    }
}
