terraform {
  backend "s3" {}
}

variable "main_title" {
  type = string
  description = "main title of dashboard"
}

variable "dashboards" {
  type = list(object({
    //"(Required) query of the widget"
    query = string
    //"(Required) How the widget visualizes data. Valid values are billboard, gauge, billboard_comparison, facet_bar_chart, faceted_line_chart, facet_pie_chart, facet_table, faceted_area_chart, heatmap, attribute_sheet, single_event, histogram, funnel, raw_json, event_feed, event_table, uniques_list, line_chart, comparison_line_chart, markdown, and metric_line_chart"
    visualization = string
    //"(Required) A title for the widget."
    title = string
    //(Required) Row position of widget from top left, starting at 1.
    row = number
    //(Required) Column position of widget from top left, starting at 1
    column = number
  }))
  description = "list dashboard property"
}