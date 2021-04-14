# https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/alert_channel

resource "newrelic_alert_channel" "email" {
  name = var.alert_channel_name
  type = "email"

  config {
    recipients = var.alert_channel_email_recipients
    include_json_attachment = "1"
  }
}
