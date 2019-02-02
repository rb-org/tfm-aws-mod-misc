data "aws_route53_zone" "zone" {
  count = "${length(local.zones)}"
  name  = "${local.zones[count.index]}"
}

data "aws_region" "current" {}
