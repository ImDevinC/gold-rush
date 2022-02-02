resource "google_dns_managed_zone" "main" {
  name     = "goldrush"
  dns_name = "isitgoldrush.com."
}

resource "google_dns_record_set" "a" {
  name         = google_dns_managed_zone.main.dns_name
  managed_zone = google_dns_managed_zone.main.name
  type         = "A"
  ttl          = 300

  rrdatas = [google_compute_global_address.main.address]
}

resource "google_dns_record_set" "cname" {
  name         = "www.${google_dns_managed_zone.main.dns_name}"
  managed_zone = google_dns_managed_zone.main.name
  type         = "CNAME"
  ttl          = 3600

  rrdatas = [google_dns_managed_zone.main.dns_name]
}


resource "google_dns_record_set" "dns_verification" {
  name         = "_acme-challenge.${google_dns_managed_zone.main.dns_name}"
  managed_zone = google_dns_managed_zone.main.name
  type         = "TXT"
  ttl          = 3600

  rrdatas = [var.letsencrypt_dns_validation]
}
