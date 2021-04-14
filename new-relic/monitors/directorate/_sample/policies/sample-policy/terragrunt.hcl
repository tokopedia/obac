include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:tokopedia/obac.git//tf-module//new-relic//alert-policy"
}

/*
dependency "slack-channel-executive" {
  config_path = "../../channels/slack/channel-executive"
}
*/

inputs = {
  alert_policy_name = "Sample Policy #1"

  /*
  alert_policy_channels = [
    "example_email",
  ]
  alert_policy_channel_ids = [
    dependency.slack-channel-executive.outputs.id,
  ]
  */
}
