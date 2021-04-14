terraform {
  backend "s3" {}
}

variable "metrics" {
  type = set(string)
  description = "list metric that want to be delete the data"
}