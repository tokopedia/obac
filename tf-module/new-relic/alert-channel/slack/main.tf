resource "newrelic_alert_channel" "slack" {
  name = var.alert_channel_name
  type = "slack"
  config {
    url     = var.alert_slack_webhook_url
  }
}