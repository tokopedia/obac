include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:tokopedia/obac.git//tf-module//new-relic//alert-policy"
}

/*
dependency "slack-executive-alert" {
  config_path = "../../channels/slack/channel-executive"
}

dependency "slack-emergency" {
  config_path = "../../channels/slack/channel-emergency"
}
*/

inputs = {
  alert_policy_name = "Sample Policy #2"

  /*
  alert_policy_channels = [
    "example_email",
  ]
  alert_policy_channel_ids = [
    dependency.slack-emergency.outputs.id,
    // dependency.slack-executive-alert.outputs.id,
  ]
  */
}
