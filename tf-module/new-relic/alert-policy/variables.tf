terraform {
  backend "s3" {}
}

variable "alert_policy_name" {
  type = string
  description = "The name of the policy"
}

variable "alert_policy_channels" {
  type = set(string)
  description = "An array of channels"
  default = []
}

variable "alert_policy_channel_ids" {
  type = list(number)
  description = "An array of channel ids"
  default = []
}
