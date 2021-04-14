terraform {
    backend "s3" {}
}

variable "alert_slack_webhook_url" {
    type = string
    description = "the name of slack webhook url"
}

variable "alert_channel_name" {
    type = string
    description = "the name of slack channel"
}
