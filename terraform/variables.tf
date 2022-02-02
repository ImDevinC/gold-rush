variable "tls_cert" {
  type        = string
  description = "ID of the TLS Certificate"
  default     = "gold-rush-tlc-cert"
}

variable "tls_key" {
  type        = string
  description = "ID of the TLS Keys"
  default     = "gold-rush-tls-key"
}

variable "letsencrypt_dns_validation" {
  type        = string
  description = "Validation string for Lets Encrypt Token"
  default     = "JPPIUQPIlUDBggDX6TUXV1esRuG6HwIOn970U8nxbbI"
}
