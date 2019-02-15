module "notify_slack_ok_cw" {
  source = "github.com/rb-org/tfm-aws-mod-sns-slack?ref=v0.0.2"

  providers {
    aws = "aws.cloudwatch"
  }

  sns_topic_name = "${local.sns_topic_ok_name}"

  slack_webhook_url    = "${var.sns_slack_webhook}"
  slack_channel        = "${local.sns_slack_channel}"
  slack_username       = "SNS Alert - OK"
  slack_emoji          = ":tada:"
  lambda_function_name = "${local.lambda_name_ok}"
  create               = "${var.create_all}"
  create_sns_topic     = "${var.create_sns_topic}"
}

module "notify_slack_urgent_cw" {
  source = "github.com/rb-org/tfm-aws-mod-sns-slack?ref=v0.0.2"

  providers {
    aws = "aws.cloudwatch"
  }

  sns_topic_name = "${local.sns_topic_urgent_name}"

  slack_webhook_url    = "${var.sns_slack_webhook}"
  slack_channel        = "${local.sns_slack_channel}"
  slack_username       = "SNS Alert - Urgent"
  slack_emoji          = ":ambulance:"
  lambda_function_name = "${local.lambda_name_urgent}"
  create               = "${var.create_all}"
  create_sns_topic     = "${var.create_sns_topic}"
}

module "notify_slack_emergency_cw" {
  source = "github.com/rb-org/tfm-aws-mod-sns-slack?ref=v0.0.2"

  providers {
    aws = "aws.cloudwatch"
  }

  sns_topic_name = "${local.sns_topic_emergency_name}"

  slack_webhook_url    = "${var.sns_slack_webhook}"
  slack_channel        = "${local.sns_slack_channel}"
  slack_username       = "SNS Alert - Emergency"
  slack_emoji          = ":fire_engine:"
  lambda_function_name = "${local.lambda_name_emergency}"
  create               = "${var.create_all}"
  create_sns_topic     = "${var.create_sns_topic}"
}

module "notify_slack_default_cw" {
  source = "github.com/rb-org/tfm-aws-mod-sns-slack?ref=v0.0.2"

  providers {
    aws = "aws.cloudwatch"
  }

  sns_topic_name = "${local.sns_topic_default_name}"

  slack_webhook_url    = "${var.sns_slack_webhook}"
  slack_channel        = "${local.sns_slack_channel}"
  slack_username       = "SNS Alert - Default"
  slack_emoji          = ":aws:"
  lambda_function_name = "${local.lambda_name_default}"
  create               = "${var.create_all}"
  create_sns_topic     = "${var.create_sns_topic}"
}
