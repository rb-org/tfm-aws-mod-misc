## Not yet supported
## https://www.terraform.io/docs/providers/aws/r/sns_topic_subscription.html#email
/*

resource "aws_sns_topic_subscription" "notify_email_ok" {
  topic_arn = "${module.notify_slack_ok.this_slack_topic_arn}"
  protocol  = "email"
  endpoint  = "${var.sns_email}"
}

resource "aws_sns_topic_subscription" "notify_email_default" {
  topic_arn = "${module.notify_slack_default.this_slack_topic_arn}"
  protocol  = "email"
  endpoint  = "${var.sns_email}"
}

resource "aws_sns_topic_subscription" "notify_email_urgent" {
  topic_arn = "${module.notify_slack_urgent.this_slack_topic_arn}"
  protocol  = "email"
  endpoint  = "${var.sns_email}"
}

resource "aws_sns_topic_subscription" "notify_email_emergency" {
  topic_arn = "${module.notify_slack_emergency.this_slack_topic_arn}"
  protocol  = "email"
  endpoint  = "${var.sns_email}"
}

*/
########################################################################
#
# Note: you can still manually setup email subscriptions.
# Be aware - the subscription has to be "confirmed" - the email address
# used as the endpoint will recieve a confirmation email
#
########################################################################

