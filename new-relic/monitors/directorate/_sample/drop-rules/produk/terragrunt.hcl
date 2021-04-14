include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:tokopedia/obac.git//tf-module//new-relic//drop-rule"
}

inputs = {
  metrics = [
    "metric_name.sum_squares",
    "metric_name.std_dev",
    "metric_name.median",
    "metric_name.mean",
  ]
}