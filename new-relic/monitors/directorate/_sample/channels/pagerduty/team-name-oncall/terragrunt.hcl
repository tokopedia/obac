include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:tokopedia/obac.git//tf-module//new-relic//alert-channel//pager-duty"
}

dependency "pager-duty-service" {
  config_path = "../../../dependency/pagerduty/service"
}

inputs = {
  alert_channel_name = "[Test] Team Name new"
  alert_service_integration_key = dependency.pager-duty-service.outputs.id
}
