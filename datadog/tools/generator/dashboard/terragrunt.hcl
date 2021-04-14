include {
	path = find_in_parent_folders()
}

terraform {
	source = "git::git@github.com:tokopedia/obac.git//tf-module//datadog//freestyle-dashboard-old"
}