include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:tokopedia/obac.git//tf-module//new-relic//alert-channel//slack"
}

inputs = {
  alert_channel_name = "Demo Obac"
  alert_slack_webhook_url = "https://someslackurl.com"
}
