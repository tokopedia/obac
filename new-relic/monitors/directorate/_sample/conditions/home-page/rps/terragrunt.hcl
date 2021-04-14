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
  nrql_alert_condition_name = "Sample Condition RPS"
  nrql_alert_condition_description = "Sample Condition Description"
  nrql_alert_condition_policy_ids = [
    dependency.policy.outputs.id,
  ]
  nrql_alert_condition_enabled = true
  nrql_alert_condition_query = "SELECT rate(count(*), 1 seconds) AS RPS FROM metric-name WHERE env = 'production' and type = 'api'"

  nrql_alert_condition_critical = {
    operator = "below"
    threshold = 1
    threshold_duration = 300
    threshold_occurrences = "ALL"
  }

  nrql_alert_condition_warning = {
    operator = "below"
    threshold = 2
    threshold_duration = 600
    threshold_occurrences = "ALL"
  }
}

