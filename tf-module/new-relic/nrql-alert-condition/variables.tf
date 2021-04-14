terraform {
  backend "s3" {}
}

variable "nrql_alert_condition_name" {
  type = string
  description = "The title of the condition"
}

variable "nrql_alert_condition_description" {
  type = string
  description = "The description of the NRQL alert condition"
  default = null
}

variable "nrql_alert_condition_policy_ids" {
  type = set(string)
  description = "The ID of the policy where this condition should be used"
}

variable "nrql_alert_condition_enabled" {
  type = bool
  description = "Whether to enable the alert condition"
  default = true
}

variable "nrql_alert_condition_query" {
  type = string
  description = "A NRQL Query"
}

variable "nrql_alert_condition_critical" {
  type = object({
    operator = string
    threshold = number
    threshold_duration = number
    threshold_occurrences = string
  })
  description = "Critical threshold values"
}

variable "nrql_alert_condition_warning" {
  type = object({
    operator = string
    threshold = number
    threshold_duration = number
    threshold_occurrences = string
  })
  description = "Warning threshold values"
}

variable "nrql_alert_condition_value_function" {
  type = string
  description =  "Possible values are single_value, sum"
  default = "single_value"
}

variable "nrql_alert_condition_violation_time_limit_seconds" {
  type = number
  description = "Time limit - will automatically force-close long lasting violation (default 300 seconds)"
  default = 300
}
