include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:tokopedia/obac.git//tf-module//new-relic//nrql-alert-condition"
}

// commented for now after we can have alert webhook url
//dependency "policy" {
//  config_path = "../../../policies/sample-policy"
//}
//
//dependency "policy2" {
//  config_path = "../../../policies/another-policy"
//}

inputs = {
  nrql_alert_condition_name = "User Validate OTP Latency"
  nrql_alert_condition_description = "User Validate OTP Latency"
  nrql_alert_condition_policy_ids = []
  nrql_alert_condition_enabled = true
  nrql_alert_condition_query = "SELECT percentile(duration, 95) * 1000 as 'Latency' FROM Transaction where request.uri='/api/v1/users/authentication/otp/validations' since 15 minutes ago"

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
