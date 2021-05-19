include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:tokopedia/obac.git//tf-module//new-relic//alert-channel//slack?ref=f_zainul_sample_local_state"
}

inputs = {
  alert_channel_name = "Team Alert"
  alert_slack_webhook_url = "https://someslackurl.com"
}
