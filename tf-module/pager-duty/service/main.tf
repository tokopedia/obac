data "pagerduty_service" "oac" {
  name = var.pagerduty_service_name
}

data "pagerduty_vendor" "new-relic" {
  name = "New Relic"
}

resource "pagerduty_service_integration" "new-relic" {
  name    = var.pagerduty_integration_service_name
  vendor  = data.pagerduty_vendor.new-relic.id
  service = data.pagerduty_service.oac.id
}
