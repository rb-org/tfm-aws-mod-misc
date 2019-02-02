##################
# Domain Join - no Chef
##################

data "aws_ssm_parameter" "domain_join_account" {
  name            = "${local.domain_join_account_location}"
  with_decryption = true
}

data "aws_ssm_parameter" "domain_join_password" {
  name            = "${local.domain_join_password_location}"
  with_decryption = true
}

data "template_file" "windows_domain_join" {
  template = "${file("${path.module}/files/windows_join_domain.tpl")}"

  vars {
    username     = "${data.aws_ssm_parameter.domain_join_account.value}"
    password     = "${data.aws_ssm_parameter.domain_join_password.value}"
    computers_ou = "${local.computers_ou}"
    domain       = "${var.ad_domain}"
  }
}

resource "aws_ssm_document" "windows_domain_join" {
  name          = "${local.windows_domain_join_doc_name}"
  document_type = "Command"
  content       = "${data.template_file.windows_domain_join.rendered}"
}

resource "aws_ssm_association" "exact_windows_domain_join" {
  name                = "${aws_ssm_document.windows_domain_join.name}"
  association_name    = "WindowsJoinDomain"
  schedule_expression = "cron(0 0 12 ? * * *)"

  targets = [
    {
      key    = "tag:JoinDomain"
      values = ["true"]
    },
    {
      key    = "tag:ChefEnabled"
      values = ["false"]
    },
  ]

  output_location {
    s3_bucket_name = "${local.output_bucket_name}"
    s3_key_prefix  = "domain-join"
  }
}
