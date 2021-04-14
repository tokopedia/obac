include {
	path = find_in_parent_folders()
}

terraform {
	source = "git::git@github.com:tokopedia/obac.git//tf-module//datadog//monitor"
}

inputs = {
	monitor_is_exec = true
	monitor_severity = "Critical"
	monitor_tribe = "Tech"
	monitor_service = "test"

	monitor_name = "Test latency {{#is_warning}}{{warn_threshold}} ms {{/is_warning}}{{#is_alert}}{{threshold}} ms {{/is_alert}}"
	monitor_type = "query alert"

	monitor_query = "avg(last_15m):avg:some_service.worker.cron.avg{env:production} > 2000"

	monitor_message = ""

	monitor_thresholds_critical = 2000

	monitor_tags = [
		"directorate:_sample_directorate",
	]

	// full downtime
	// monitor_silenced = true

	//	monitor_downtime = {
	//		start_time = "17:00"
	//		duration = "8h"
	//		recurrence_type = "days"
	//		recurrence_period = 1
	//	}

	monitor_related_jenkins_job_names = [
		"jenkins-job-name",
	]
}
