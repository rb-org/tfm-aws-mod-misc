output "ok_slack_topic_arn" {
  value = "${module.notify_slack_ok.this_slack_topic_arn}"
}

output "urgent_slack_topic_arn" {
  value = "${module.notify_slack_urgent.this_slack_topic_arn}"
}

output "emergency_slack_topic_arn" {
  value = "${module.notify_slack_emergency.this_slack_topic_arn}"
}

output "default_slack_topic_arn" {
  value = "${module.notify_slack_default.this_slack_topic_arn}"
}

output "ok_slack_topic_cw_arn" {
  value = "${module.notify_slack_ok_cw.this_slack_topic_arn}"
}

output "urgent_slack_topic_cw_arn" {
  value = "${module.notify_slack_urgent_cw.this_slack_topic_arn}"
}

output "emergency_slack_topic_cw_arn" {
  value = "${module.notify_slack_emergency_cw.this_slack_topic_arn}"
}

output "default_slack_topic_cw_arn" {
  value = "${module.notify_slack_default_cw.this_slack_topic_arn}"
}
