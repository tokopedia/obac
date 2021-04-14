# https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/alert_channel

locals {
  load = <<EOF
{
  "account_id": "$ACCOUNT_ID",
  "account_name": "$ACCOUNT_NAME",
  "closed_violations_count_critical": "$CLOSED_VIOLATIONS_COUNT_CRITICAL",
  "closed_violations_count_warning": "$CLOSED_VIOLATIONS_COUNT_WARNING",
  "condition_description": "$DESCRIPTION",
  "condition_family_id": "$CONDITION_FAMILY_ID",
  "condition_name": "$CONDITION_NAME",
  "current_state": "$EVENT_STATE",
  "details": "$EVENT_DETAILS",
  "duration": "$DURATION",
  "event_type": "$EVENT_TYPE",
  "incident_acknowledge_url": "$INCIDENT_ACKNOWLEDGE_URL",
  "incident_id": "$INCIDENT_ID",
  "incident_url": "$INCIDENT_URL",
  "metadata": "$METADATA",
  "open_violations_count_critical": "$OPEN_VIOLATIONS_COUNT_CRITICAL",
  "open_violations_count_warning": "$OPEN_VIOLATIONS_COUNT_WARNING",
  "owner": "$EVENT_OWNER",
  "policy_name": "$POLICY_NAME",
  "policy_url": "$POLICY_URL",
  "runbook_url": "$RUNBOOK_URL",
  "severity": "$SEVERITY",
  "targets": "$TARGETS",
  "timestamp": "$TIMESTAMP",
  "violation_callback_url": "$VIOLATION_CALLBACK_URL",
  "violation_chart_url": "$VIOLATION_CHART_URL",
  "channel": "%s",
  "bypass_warn": %v
}
    EOF
}

resource "newrelic_alert_channel" "slack" {
  name = var.alert_channel_name
  type = "webhook"

  config {
    base_url = "http://your-server/webhook/newrelic/reply-in-thread"
    payload_string = format(
      local.load,
      var.alert_channel_slack_channel_id,
      var.alert_channel_slack_bypass_warn,
    )
    payload_type = "application/json"
  }
}
