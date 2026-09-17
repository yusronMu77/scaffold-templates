[package]
name = "{{ .CrateName }}"
version = "0.0.1"
edition = "{{ .RustEdition }}"
description = "{{ .Description }}"

[dependencies]
axum = "0.7"
tokio = { version = "1", features = ["full"] }
# @scaffold:dependencies

[dev-dependencies]
tower = { version = "0.5", features = ["util"] }
http-body-util = "0.1"
