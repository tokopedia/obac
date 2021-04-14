include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:tokopedia/obac.git//tf-module//pager-duty//service"
}

inputs = {
  pagerduty_service_name = "[Test] Service Name"
  pagerduty_integration_service_name = "[Test] Pagerduty OBAC Integration"
}
