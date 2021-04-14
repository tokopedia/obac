terraform {
	backend "s3" {}
}

variable "monitor_is_exec" {
	type = bool
	description = "is executive monitor"
}

variable "monitor_severity" {
	type = string
	description = "severity"
}

variable "monitor_tribe" {
	type = string
	description = "this monitor belongs to which tribe"
}

variable "monitor_service" {
	type = string
	description = "this monitor belongs to which service"
}

variable "monitor_name" {
	type = string
	description = "monitor name"
}

variable "monitor_type" {
	type = string
	description = "monitor type"
}

variable "monitor_query" {
	type = string
	description = "monitor query"
}

variable "monitor_message" {
  type = string
  description = "alert message"
}

variable "monitor_renotify_interval" {
	type = number
	description = "alert escalation interval"
	default = null
}

variable "monitor_escalation_message" {
	type = string
	description = "alert escalation message"
	default = null
}

variable "monitor_thresholds_warning" {
	type = number
	default = null
}

variable "monitor_thresholds_warning_recovery" {
	type = number
	default = null
}

variable "monitor_thresholds_critical" {
	type = number
	default = null
}

variable "monitor_thresholds_critical_recovery" {
	type = number
	default = null
}

variable "monitor_threshold_windows_recovery_window" {
	type = string
	default = null
}

variable "monitor_threshold_windows_trigger_window" {
	type = string
	default = null
}

variable "monitor_tags" {
	type = list(string)
	description = "tags"
}

variable "monitor_silenced" {
	type = bool
	description = "mute this monitor"
	default = false
}

variable "monitor_downtime" {
	type = object({
		start_time = string
		duration = string
		recurrence_type = string
		recurrence_period = number
	})
	default = null
}

variable "monitor_notify_no_data" {
  type        = bool
  description = "notify no data"
  default     = false
}

variable "monitor_no_data_timeframe" {
  type        = number
  description = "the number of minutes before a monitor will notify when data stops reporting"
  default     = 10
}

variable "monitor_related_jenkins_job_names" {
  type = list(string)
  description = "list of related jenkins job name"
  default = []
}
