terraform {
    backend "s3" {}
}

variable "alert_channel_name" {
    type = string
    description = "the name of pagerduty channel"
}

variable "alert_service_integration_key" {
    type = string
    description = "the service integration key"
}