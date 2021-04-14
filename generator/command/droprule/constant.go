package droprule

const tmpl = `
include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:tokopedia/obac.git//tf-module//new-relic//dashboard"
}

inputs = {
  main_title = "Drop Rule Summary Directorate %s"
  dashboards = [
    {
      query = <<EOF
        FROM Metric
        select datapointcount() since today until now timeseries facet metricName
        where metricName
        in (%s)
        WITH TIMEZONE 'Asia/Singapore' limit max
      EOF
      visualization="faceted_line_chart"
      title="list of metric already apply drop rule"
      row=1
      column=1
      width=1
      height=1
    },
	{
      query = <<EOF
        FROM Metric
        select datapointcount() since today until now timeseries facet metricName
        WITH TIMEZONE 'Asia/Singapore' limit 20
      EOF
      visualization="faceted_line_chart"
      title="top 20 metric"
      row=1
      column=2
      width=1
      height=1
    },
    {
      query = <<EOF
        FROM Metric
        select datapointcount() since today until now facet metricName
        where metricName
        in (%s)
        WITH TIMEZONE 'Asia/Singapore' limit max
      EOF
      visualization="event_table"
      title="list of metric already apply drop rule table view"
      row=2
      column=1
      width=1
      height=1
    },
	{
      query = <<EOF
        FROM Metric
        select datapointcount() since today until now facet metricName
        WITH TIMEZONE 'Asia/Singapore' limit 20
      EOF
      visualization="event_table"
      title="top 20 metric table view"
      row=2
      column=2
      width=1
      height=1
    },
  ]
}
`
