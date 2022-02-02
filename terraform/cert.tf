data "google_secret_manager_secret_version" "cert" {
  secret = var.tls_cert
}

data "google_secret_manager_secret_version" "key" {
  secret = var.tls_key
}

resource "google_compute_ssl_certificate" "main" {
  name_prefix = "gold-rush"
  private_key = data.google_secret_manager_secret_version.key.secret_data
  certificate = data.google_secret_manager_secret_version.cert.secret_data

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_ssl_policy" "main" {
  name            = "gold-rush"
  profile         = "MODERN"
  min_tls_version = "TLS_1_2"
}
