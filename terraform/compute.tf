resource "google_compute_global_address" "main" {
  name = "gold-rush"
}

resource "google_compute_backend_bucket" "main" {
  name        = "gold-rush"
  bucket_name = google_storage_bucket.main.name
  enable_cdn  = false
}

resource "google_compute_url_map" "main" {
  name            = "gold-rush"
  default_service = google_compute_backend_bucket.main.id
}

resource "google_compute_url_map" "redirect" {
  name = "gold-rush-redirect"
  default_url_redirect {
    https_redirect = true
    strip_query    = false
  }
}

resource "google_compute_target_https_proxy" "main" {
  name             = "gold-rush"
  url_map          = google_compute_url_map.main.id
  ssl_certificates = [google_compute_ssl_certificate.main.id]
  ssl_policy       = google_compute_ssl_policy.main.id
}

resource "google_compute_target_http_proxy" "main" {
  name    = "gold-rush-redirect"
  url_map = google_compute_url_map.redirect.id
}

resource "google_compute_global_forwarding_rule" "main" {
  name                  = "gold-rush"
  target                = google_compute_target_https_proxy.main.id
  port_range            = "443"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.main.id
}

resource "google_compute_global_forwarding_rule" "redirect" {
  name                  = "gold-rush-redirect"
  target                = google_compute_target_http_proxy.main.id
  port_range            = "80"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.main.id
}
