resource "newrelic_dashboard" "oac_dashboard" {
  title = var.main_title

  filter {
    event_types = [
        "Transaction"
    ]
    attributes = [
        "appName",
        "name",
        "metricName",
    ]
  }

  dynamic "widget" {
    for_each = var.dashboards

    content {
      title = widget.value.title
      visualization = widget.value.visualization
      nrql = widget.value.query
      row = widget.value.row
      column = widget.value.column
    }

  }
}