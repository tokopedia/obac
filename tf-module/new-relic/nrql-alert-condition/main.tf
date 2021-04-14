# https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition#threshold

resource "newrelic_nrql_alert_condition" "condition" {
  for_each = var.nrql_alert_condition_policy_ids

  name = var.nrql_alert_condition_name
  policy_id = each.key
  description = var.nrql_alert_condition_description
  enabled = var.nrql_alert_condition_enabled

  nrql {
    query = var.nrql_alert_condition_query
    evaluation_offset = 3
  }

  critical {
    operator = var.nrql_alert_condition_critical.operator
    threshold = var.nrql_alert_condition_critical.threshold
    threshold_duration = var.nrql_alert_condition_critical.threshold_duration
    threshold_occurrences = var.nrql_alert_condition_critical.threshold_occurrences
  }

  warning {
    operator = var.nrql_alert_condition_warning.operator
    threshold = var.nrql_alert_condition_warning.threshold
    threshold_duration = var.nrql_alert_condition_warning.threshold_duration
    threshold_occurrences = var.nrql_alert_condition_warning.threshold_occurrences
  }

  value_function = var.nrql_alert_condition_value_function
  violation_time_limit_seconds = var.nrql_alert_condition_violation_time_limit_seconds
}
