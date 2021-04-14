remote_state {
  backend = "s3"
  config  = {
    bucket         = "replace with your bucket"
    key            = "replace your key"
    endpoint       = "https://s3-ap-southeast-1.amazonaws.com"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "replace with your dynamo table for lock"
    profile         = "replace with your profile"
  }
}

terraform {
  extra_arguments "extra" {
    commands = "${get_terraform_commands_that_need_vars()}"
  }
}
