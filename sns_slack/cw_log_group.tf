resource "aws_cloudwatch_log_group" "default" {
  count             = "${local.create_log_group}"
  name              = "/aws/lambda/${local.sns_topic_default_name}"
  retention_in_days = "${var.log_group_retention}"

  tags = "${merge(
    var.default_tags, 
    map(
      "Name", "${local.sns_topic_default_name}",
      "Environment", "${terraform.workspace}",
    )
  )}"
}

resource "aws_cloudwatch_log_group" "emergency" {
  count             = "${local.create_log_group}"
  name              = "/aws/lambda/${local.sns_topic_emergency_name}"
  retention_in_days = "${var.log_group_retention}"

  tags = "${merge(
    var.default_tags, 
    map(
      "Name", "${local.sns_topic_emergency_name}",
      "Environment", "${terraform.workspace}",
    )
  )}"
}

resource "aws_cloudwatch_log_group" "ok" {
  count             = "${local.create_log_group}"
  name              = "/aws/lambda/${local.sns_topic_ok_name}"
  retention_in_days = "${var.log_group_retention}"

  tags = "${merge(
    var.default_tags, 
    map(
      "Name", "${local.sns_topic_ok_name}",
      "Environment", "${terraform.workspace}",
    )
  )}"
}

resource "aws_cloudwatch_log_group" "urgent" {
  count             = "${local.create_log_group}"
  name              = "/aws/lambda/${local.sns_topic_urgent_name}"
  retention_in_days = "${var.log_group_retention}"

  tags = "${merge(
    var.default_tags, 
    map(
      "Name", "${local.sns_topic_urgent_name}",
      "Environment", "${terraform.workspace}",
    )
  )}"
}
