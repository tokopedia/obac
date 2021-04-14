output "id" {
  value = {
    for key in var.nrql_alert_condition_policy_ids:
      key => ({ "id" = newrelic_nrql_alert_condition.condition[key].id })
  }
}
