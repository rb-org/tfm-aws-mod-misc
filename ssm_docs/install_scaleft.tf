##################
# Install ScaleFT
##################

resource "aws_ssm_document" "install_scaleft" {
  name          = "${local.install_scaleft_doc_name}"
  document_type = "Command"
  content       = "${file("${path.module}/files/install_scaleft.json")}"
}

resource "aws_ssm_association" "install_scaleft" {
  name                = "${aws_ssm_document.install_scaleft.name}"
  association_name    = "InstallScaleFT"
  schedule_expression = "cron(0 0 12 ? * * *)"

  targets = [{
    key    = "tag:PassportEnabled"
    values = ["true"]
  }]
}
