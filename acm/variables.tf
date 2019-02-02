variable "domains" {
  type        = "map"
  description = "A map {\"zone.com.\" = [\"zone.com\",\"www.zone.com\"],\"foo.com\" = [\"foo.com\"] } of domains."
}

# variable "region" {
#   default = "eu-west-1"
# }

variable "tags" {
  type    = "map"
  default = {}
}

variable "ssl_cert_primary_name" {}

variable "create_certs" {
  default = true
}
