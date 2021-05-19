terraform {
  backend "local" {}
}

variable "pagerduty_service_name" {
  type = string
  description = "(Required) The service name to use to find a service in the PagerDuty API."
}

variable "pagerduty_integration_service_name" {
  type = string
  description = "The integration service name"
}