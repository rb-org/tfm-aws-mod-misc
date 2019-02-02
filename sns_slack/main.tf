provider "aws" {
  alias  = "cloudwatch"
  region = "us-east-1"
}

/*
provider "aws" {
  alias  = "general"
  region = "${data.aws_region.current.name}"
}

data "aws_region" "current" {}
*/

