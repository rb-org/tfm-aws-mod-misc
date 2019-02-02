resource "aws_sns_topic_subscription" "notify_victorops_ok" {
  count                  = "${local.create_vo_topic}"
  topic_arn              = "${module.notify_slack_ok.this_slack_topic_arn}"
  protocol               = "https"
  endpoint               = "${local.victorops_url}"
  endpoint_auto_confirms = true
}

resource "aws_sns_topic_subscription" "notify_victorops_default" {
  count = "${local.create_vo_topic}"

  topic_arn              = "${module.notify_slack_default.this_slack_topic_arn}"
  protocol               = "https"
  endpoint               = "${local.victorops_url}"
  endpoint_auto_confirms = true
}

resource "aws_sns_topic_subscription" "notify_victorops_urgent" {
  count                  = "${local.create_vo_topic}"
  topic_arn              = "${module.notify_slack_urgent.this_slack_topic_arn}"
  protocol               = "https"
  endpoint               = "${local.victorops_url}"
  endpoint_auto_confirms = true
}

resource "aws_sns_topic_subscription" "notify_victorops_emergency" {
  count                  = "${local.create_vo_topic}"
  topic_arn              = "${module.notify_slack_emergency.this_slack_topic_arn}"
  protocol               = "https"
  endpoint               = "${local.victorops_url}"
  endpoint_auto_confirms = true
}

resource "aws_sns_topic_subscription" "notify_victorops_ok_cw" {
  count                  = "${local.create_vo_topic}"
  provider               = "aws.cloudwatch"
  topic_arn              = "${module.notify_slack_ok_cw.this_slack_topic_arn}"
  protocol               = "https"
  endpoint               = "${local.victorops_url}"
  endpoint_auto_confirms = true
}

resource "aws_sns_topic_subscription" "notify_victorops_default_cw" {
  count                  = "${local.create_vo_topic}"
  provider               = "aws.cloudwatch"
  topic_arn              = "${module.notify_slack_default_cw.this_slack_topic_arn}"
  protocol               = "https"
  endpoint               = "${local.victorops_url}"
  endpoint_auto_confirms = true
}

resource "aws_sns_topic_subscription" "notify_victorops_urgent_cw" {
  count                  = "${local.create_vo_topic}"
  provider               = "aws.cloudwatch"
  topic_arn              = "${module.notify_slack_urgent_cw.this_slack_topic_arn}"
  protocol               = "https"
  endpoint               = "${local.victorops_url}"
  endpoint_auto_confirms = true
}

resource "aws_sns_topic_subscription" "notify_victorops_emergency_cw" {
  count                  = "${local.create_vo_topic}"
  provider               = "aws.cloudwatch"
  topic_arn              = "${module.notify_slack_emergency_cw.this_slack_topic_arn}"
  protocol               = "https"
  endpoint               = "${local.victorops_url}"
  endpoint_auto_confirms = true
}
