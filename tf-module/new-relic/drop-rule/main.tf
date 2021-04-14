/*locals {
  //  currently is not use
  st_func = ["sum_squares", "std_dev", "median", "mean", "sum_squares.percentiles", "mean.percentiles"]
}*/

resource "newrelic_nrql_drop_rule" "oac" {
 for_each = var.metrics

  description = format("filter drop rule for metric %s ", each.value)
  action = "drop_data"
  nrql =  format("select * from Metric where metricName = '%s' and mod(timestamp/10000,2)!=0", each.value)
}
