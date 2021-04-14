include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:tokopedia/obac.git//tf-module//new-relic//nrql-alert-condition"
}

dependency "policy" {
  config_path = "../../../policies/sample-policy"
}

inputs = {
  nrql_alert_condition_name = "Sample Condition Latency testing obac"
  nrql_alert_condition_description = "Sample Condition Description"
  nrql_alert_condition_policy_ids = [
    dependency.policy.outputs.id,
  ]
  nrql_alert_condition_enabled = true
  nrql_alert_condition_query = "SELECT percentile(timer, 95) AS Latency FROM metric-name WHERE type='api'"

  nrql_alert_condition_critical = {
    operator = "above"
    threshold = 1000
    threshold_duration = 300
    threshold_occurrences = "ALL"
  }

  nrql_alert_condition_warning = {
    operator = "above"
    threshold = 500
    threshold_duration = 600
    threshold_occurrences = "ALL"
  }
}
