resource "datadog_monitor" "monitor" {
	type = var.monitor_type

	name = format(
		"[%s][%s][%s]%s%s",
		var.monitor_severity,
		var.monitor_tribe,
		var.monitor_service,
		var.monitor_name,
		(var.monitor_is_exec ? " [Exec]": ""),
	)

	message = var.monitor_message

  notify_no_data    = var.monitor_notify_no_data
  no_data_timeframe = var.monitor_no_data_timeframe

	renotify_interval  = var.monitor_renotify_interval
	escalation_message = var.monitor_escalation_message

	query = var.monitor_query

	thresholds = {
		warning = var.monitor_thresholds_warning
		warning_recovery = var.monitor_thresholds_warning_recovery
		critical = var.monitor_thresholds_critical
		critical_recovery = var.monitor_thresholds_critical_recovery
	}

	threshold_windows = {
	    recovery_window = var.monitor_threshold_windows_recovery_window
	    trigger_window = var.monitor_threshold_windows_trigger_window
	}

	tags = compact(concat(var.monitor_tags, [
		(var.monitor_is_exec?"level:exec":""),
		lower("tribe:${var.monitor_tribe}"),
		lower("service:${var.monitor_service}"),
		"tg-monitoring"],
    formatlist("jenkins:%s", var.monitor_related_jenkins_job_names),
	))

	# ignore downtime - silenced is deprecated
	lifecycle {
		ignore_changes = [silenced]
	}

	# locked for creator and admin only
	locked = true
}

resource "datadog_downtime" "silenced" {
	count = var.monitor_silenced ? 1:0

	scope = ["*"]
	monitor_id = datadog_monitor.monitor.id
}

locals {
	// utc -> wib
	now = timeadd(timestamp(), "7h")
	want = try(format("%sT%s:00Z", formatdate("YYYY-MM-DD", local.now), var.monitor_downtime.start_time), null)

	now_time = try(tonumber(formatdate("h", local.now)) * 60 + tonumber(formatdate("m", local.now)), null)
	want_time = try(tonumber(formatdate("h", local.want)) * 60 + tonumber(formatdate("m", local.want)), null)

	start_date = try(timeadd(local.now_time < local.want_time?local.want:timeadd(local.want, "24h"), "-7h"), null)
	end_date = try(timeadd(local.start_date, var.monitor_downtime.duration), null)
}

resource "datadog_downtime" "downtime" {
	count = (!var.monitor_silenced && try(var.monitor_downtime.start_time, "") != "") ? 1:0

	scope = ["*"]
	monitor_id = datadog_monitor.monitor.id

	start_date = local.start_date
	end_date = local.end_date
	timezone = "Asia/Jakarta"

	recurrence {
		type = var.monitor_downtime.recurrence_type
		period = var.monitor_downtime.recurrence_period
	}

	lifecycle {
		ignore_changes = [
			start,
			end
		]
	}
}
