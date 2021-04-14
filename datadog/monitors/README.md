## Input Reference

#### Main (Mandatory)
- `monitor_is_exec` - Is this a monitor for executive dashboard?
- `monitor_severity` - The severity of the monitor.
- `monitor_tribe` - Tribe name.
- `monitor_service` - Service name.
- `monitor_name` - Monitor name. **Note**: The system will automatically re-format your monitor name according to a standardize format.
- `monitor_type` - Currently, only 1 type is being supported `query alert`.
- `monitor_query` - The metric that define the monitor.
- `monitor_message` - Describe what is happening here. Also, include your notification.
- `monitor_tags` - Please include `directorate:<your-directorate>` tag for easier identification.
- `monitor_related_jenkins_job_names` - Please include `jenkins:<your-job-deployment-project-name>` 

#### Thresholds
- `monitor_thresholds_critical` (*float*) - **Mandatory** for both Threshold and Anomaly Monitor.
- `monitor_thresholds_warning` (*float*) - **Mandatory for Executive Threshold Monitor**
- `monitor_thresholds_critical_recovery` (*float*) - **Optional** 
- `monitor_thresholds_warning_recovery` (*float*) - **Optional**
- `monitor_threshold_windows_recovery_window` (*string*) - **Mandatory** for Anomaly Monitor.
- `monitor_threshold_windows_trigger_window` (*string*) - **Mandatory** for Anomaly Monitor.

 **Note** Possible value for `monitor_threshold_windows_*`: `last_5m`, `last_10m`, `last_15m`, `last_30m`


#### Mute/Scheduled Downtime (Optional)
- `monitor_silenced` - Mute the monitor (true / false)
- `monitor_downtime` - Schedule specific downtime. Mandatory options:
   - `start_time` (*string*) - When should we start? Format: `hh:mm` (24-hour)
   - `duration` (*string*) - How long? Format: `<integer>h` (h for hour)
   - `recurrence_type` (*string*) - Currently supported option: `days`, `weeks`, `months` or `years`
   - `recurrence_period` (*number*) - How often to repeat?


## Example
#### Threshold Monitor Example
```
include {
	path = find_in_parent_folders()
}
  
terraform {
	source = "git::git@github.com:tokopedia/tf-monitoring-modules.git//datadog//monitor"
}
  
inputs = {
	monitor_is_exec = false
	monitor_severity = "Critical"
	monitor_tribe = "Tech"
	monitor_service = "test"

	monitor_name = "Test RPS {{#is_warning}}{{warn_threshold}} RPS {{/is_warning}}{{#is_alert}}{{threshold}} RPS {{/is_alert}}"
	monitor_type = "query alert"
    
	monitor_query = "sum(last_4h):sum:some_metric{some_tag,success}/sum:some_metric{some_tag} * 100 < 90"
  
	monitor_message = <<EOF
	Please check <@U64M2JL3H>
  
	@slack-911_alert-temp_staging_911
	EOF
  
	monitor_thresholds_warning = 95
	monitor_thresholds_warning_recovery = 96
	monitor_thresholds_critical = 90.0
	// monitor_thresholds_critical_recovery = 0.0

	monitor_tags = [
		"directorate:_sample_directorate",
	]
  
	monitor_related_jenkins_job_names = [
		"go-search-microservice-v2",
		"Filtron"
	]

	monitor_silenced = true
}
```

#### Anomaly Monitor Example
```
include {
	path = find_in_parent_folders()
}
  
terraform {
	source = "git::git@github.com:tokopedia/tf-monitoring-modules.git//datadog//monitor"
}
  
inputs = {
	monitor_is_exec = false
	monitor_severity = "Critical"
	monitor_tribe = "Tech"
	monitor_service = "test"

	monitor_name = "Test RPS Anomaly"
	monitor_type = "query alert"
  
	monitor_message = <<EOF
	@slack-911_alert-911-temp-staging-911
	EOF
  
	monitor_query = "sum(last_4h):anomalies(sum:liquibase.worker.cron{env:master}.as_rate(), 'basic', 2, direction='both', alert_window='last_15m', interval=60, count_default_zero='true') >= 1"
  
	monitor_thresholds_critical = 1.0

	monitor_threshold_windows_recovery_window = "last_15m"
	monitor_threshold_windows_trigger_window = "last_15m"

	monitor_tags = [
		"directorate:_sample_directorate",
	]

	monitor_related_jenkins_job_names = [
		"go-search-microservice-v2",
		"Filtron"
	]

	monitor_downtime = {
		start_time = "17:00"
		duration = "8h"
		recurrence_type = "days"
		recurrence_period = 1
	}
}
```
