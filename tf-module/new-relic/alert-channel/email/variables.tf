terraform {
  backend "s3" {}
}

variable "alert_channel_name" {
  type = string
  description = "The name of the channel"
}

variable "alert_channel_email_recipients" {
  type = string
  description = "Comma delimited list of email addresses"
}
