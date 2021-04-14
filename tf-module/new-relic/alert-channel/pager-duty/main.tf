resource "newrelic_alert_channel" "pagerduty" {
  name = var.alert_channel_name
  type = "pagerduty"
  config {
    service_key = var.alert_service_integration_key
  }
}