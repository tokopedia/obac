terraform {
  backend "s3" {}
}

variable "alert_channel_name" {
  type = string
  description = "The name of the channel"
}

variable "alert_channel_slack_channel_id" {
  type = string
  description = "Slack channel ID"
}

variable "alert_channel_slack_bypass_warn" {
  type = bool
  description = "Bypass warning"
  default = false
}
