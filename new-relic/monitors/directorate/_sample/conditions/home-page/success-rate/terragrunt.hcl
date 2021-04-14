include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:tokopedia/obac.git//tf-module//new-relic//nrql-alert-condition"
}

dependency "policy" {
  config_path = "../../../policies/sample-policy"
}

dependency "policy2" {
  config_path = "../../../policies/another-policy"
}

inputs = {
  nrql_alert_condition_name = "Sample Condition Success Rate"
  nrql_alert_condition_description = "Sample Condition Description"
  nrql_alert_condition_policy_ids = [
    dependency.policy.outputs.id,
    dependency.policy2.outputs.id,
  ]
  nrql_alert_condition_enabled = true
  nrql_alert_condition_query = "SELECT percentage(count(*), where boolean(is_success) IS true) as SuccessRate from somemetric"

  nrql_alert_condition_critical = {
    operator = "below"
    threshold = 95
    threshold_duration = 300
    threshold_occurrences = "ALL"
  }

  nrql_alert_condition_warning = {
    operator = "below"
    threshold = 99
    threshold_duration = 600
    threshold_occurrences = "ALL"
  }
}
