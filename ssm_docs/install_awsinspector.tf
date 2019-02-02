#############################
# Install AWS Inspector Agent
#############################

data "aws_ssm_document" "install_awsinspector" {
  name             = "AmazonInspector-ManageAWSAgent"
  document_version = "7"
}

resource "aws_ssm_association" "install_awsinspector" {
  name                = "${data.aws_ssm_document.install_awsinspector.name}"
  association_name    = "InstallAWSInspector"
  schedule_expression = "cron(45 13 * * ? *)"

  parameters {
    Operation = "Install"
  }

  targets = [{
    key    = "tag:AWSInspectorEnabled"
    values = ["true"]
  }]
}
