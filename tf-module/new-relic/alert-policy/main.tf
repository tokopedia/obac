# https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/alert_policy

data "newrelic_alert_channel" "channels" {
  for_each = var.alert_policy_channels
  name = each.key
}

resource "newrelic_alert_policy" "policy" {
  name = var.alert_policy_name
  incident_preference = "PER_CONDITION"

  channel_ids = toset(flatten([
    var.alert_policy_channel_ids,
    [ for k in var.alert_policy_channels: data.newrelic_alert_channel.channels[k].id ]
  ]))
}
