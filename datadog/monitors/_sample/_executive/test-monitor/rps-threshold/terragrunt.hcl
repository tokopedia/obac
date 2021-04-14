
include {
	path = find_in_parent_folders()
}
  
terraform {
	source = "git::git@github.com:tokopedia/obac.git//tf-module//datadog//monitor"
}
  
inputs = {
	monitor_is_exec = false
	monitor_severity = "Critical"
	monitor_tribe = "Tech"
	monitor_service = "test"

	monitor_name = "Test RPS {{#is_warning}}{{warn_threshold}} RPS {{/is_warning}}{{#is_alert}}{{threshold}} RPS {{/is_alert}}"
	monitor_type = "query alert"
  
	monitor_message = <<EOF
	@slack-911_alert-911-temp-staging-911
	EOF
  
	monitor_query = "sum(last_4h):sum:some_service.worker.cron{env:master}.as_rate() * 100 <= 0"
  
	monitor_thresholds_warning = 1.0
	monitor_thresholds_warning_recovery = 1.1
	monitor_thresholds_critical = 0.0
	// monitor_thresholds_critical_recovery = 0.0

	monitor_tags = [
		"directorate:_sample_directorate",
	]

	// full downtime
	// monitor_silenced = true

	monitor_downtime = {
		start_time = "17:00"
		duration = "8h"
		recurrence_type = "days"
		recurrence_period = 1
	}
}