
include {
	path = find_in_parent_folders()
}

terraform {
	source = "git::git@github.com:tokopedia/obac.git//tf-module//datadog//monitor"
}

inputs = {
	monitor_is_exec = true
	monitor_severity = "Severe"
	monitor_tribe = "Tech"
	monitor_service = "Tg-monitoring"

	monitor_name = "This is a test monitor abcdefg"
	monitor_type = "query alert"


	monitor_query = "sum(last_5m):sum:user.success_login{env:production}.as_count() * 100 < 90"

	monitor_message = <<EOF
	@slack-911_alert-temp_staging_911
	EOF

	monitor_renotify_interval = 10
	monitor_escalation_message = <<EOF
	Test
	EOF

	// monitor_thresholds_warning = 0
	// monitor_thresholds_warning_recovery = 0
	monitor_thresholds_critical = 90.0
	monitor_thresholds_critical_recovery = 91.0

	// monitor_threshold_windows_recovery_window = "last_15m"
	// monitor_threshold_windows_trigger_window = "last_15m"

	monitor_tags = [
		"directorate:accounts-and-user-platform",
	]
}
