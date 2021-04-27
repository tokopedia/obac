include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:tokopedia/obac.git//tf-module//new-relic//alert-policy"
}


dependency "slack-channel-team-user" {
  config_path = "../../channels/slack/team-alert"
}


inputs = {
  alert_policy_name = "Sample Policy #1 Obac"

  /*
  alert_policy_channels = [
    "example_email",
  ]
  */
  alert_policy_channel_ids = [
    dependency.slack-channel-team-user.outputs.id,
  ]

}
