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
