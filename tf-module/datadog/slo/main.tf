resource "datadog_service_level_objective" "slo" {
  name        = "Example Monitor SLO"
  type        = "monitor"
  description = "My custom monitor SLO"
  monitor_ids = var.slo_monitor_ids

  thresholds {
    timeframe = "7d"
    target = 99.9
  }
}
