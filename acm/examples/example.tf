module "cert" {
  source = "../../terraform-aws-excp-misc//acm"

  domains = {
    "${var.r53_dns_domain_pub}." = "${local.https_listener_ssl_cert_names}"
    "my_test_domain."            = ["*.my_test_domain"]
  }

  ssl_cert_primary_name = "${local.ssl_cert_primary_name[0]}"
  region                = "eu-west-1"
}

locals {
  https_listener_ssl_cert_names = "${concat(local.ssl_cert_primary_name,local.ssl_cert_sans)}"
  ssl_cert_primary_name         = ["splunksearch.${var.r53_dns_domain_pub}"]

  ssl_cert_sans = [
    "splunkrestapi.${var.r53_dns_domain_pub}",
    "splunkmgmt.${var.r53_dns_domain_pub}",
    "splunkmc.${var.r53_dns_domain_pub}",
    "splunksearch2.${var.r53_dns_domain_pub}",
    "splunkrestapi2.${var.r53_dns_domain_pub}",
  ]
}

variable "r53_dns_domain_pub" {
  default = "dev-mgmtexcp.nl"
}
