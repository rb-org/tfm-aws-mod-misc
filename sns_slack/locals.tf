locals {
  name_prefix = "${terraform.workspace}"

  sns_topic_ok_name        = "${local.name_prefix}-ok"
  sns_topic_emergency_name = "${local.name_prefix}-emergency"
  sns_topic_urgent_name    = "${local.name_prefix}-urgent"
  sns_topic_default_name   = "${local.name_prefix}-default"
  sns_slack_channel        = "excp-sns-${local.name_prefix}"
  lambda_name_ok           = "${local.name_prefix}-sns-alert-ok"
  lambda_name_emergency    = "${local.name_prefix}-sns-alert-emergency"
  lambda_name_urgent       = "${local.name_prefix}-sns-alert-urgent"
  lambda_name_default      = "${local.name_prefix}-sns-alert-default"
  victorops_url            = "${var.victorops_webhook}${var.victorops_routing_key}"
  create_log_group         = "${var.create_log_group ? 1 : 0}"
  create_vo_topic          = "${var.create_sns_topic ? 1 : 0}"
}
