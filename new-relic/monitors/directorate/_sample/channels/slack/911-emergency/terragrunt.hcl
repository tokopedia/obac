include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:tokopedia/obac.git//tf-module//new-relic//alert-channel//threaded-slack"
}

inputs = {
  alert_channel_name = "911-emergency"

  alert_channel_slack_channel_id = "ABCDEXYZ"
  alert_channel_slack_bypass_warn = false
}
