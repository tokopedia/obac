include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:tokopedia/obac.git//tf-module//new-relic//alert-policy"
}

/*
dependency "slack-911-executive-alert" {
  config_path = "../../channels/slack/911-executive-alert"
}

dependency "slack-911-emergency" {
  config_path = "../../channels/slack/911-emergency"
}
*/

inputs = {
  alert_policy_name = "Sample Policy #2"

  /*
  alert_policy_channels = [
    "example_email",
  ]
  alert_policy_channel_ids = [
    dependency.slack-911-emergency.outputs.id,
    // dependency.slack-911-executive-alert.outputs.id,
  ]
  */
}
