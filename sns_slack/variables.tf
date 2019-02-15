variable "sns_slack_webhook" {}
variable "sns_email" {}

variable "victorops_routing_key" {}
variable "victorops_webhook" {}

variable "log_group_retention" {
  default = 7
}

variable "create_log_group" {
  default = true
}

variable "default_tags" {
  type = "map"
}

variable "create_all" {
  default = false
}

variable "create_sns_topic" {
  default = false
}

variable "use_source_hash" {
  default = false
}
