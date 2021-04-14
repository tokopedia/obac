output "query" {
  value = regex(
  	"^(?P<aggregator>[^(]+).*\\):(?P<q>[^><]+)[ ]*(?P<comparator>[^ \\d]+)",
	datadog_monitor.monitor.query
  )
}

output "thresholds" {
  value = datadog_monitor.monitor.thresholds
}

output "monitor_id" {
  value = datadog_monitor.monitor.id
}
