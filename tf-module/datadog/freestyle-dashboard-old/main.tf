resource "datadog_dashboard" "dashboard" {
  is_read_only = true
  layout_type  = "free"
  notify_list  = []

  title        = var.fd_title
  description  = var.fd_description

  dynamic "widget" {
    for_each = var.fd_free_text_widgets
    content {
      layout = widget.value.layout
      free_text_definition {
        text = widget.value.text
        color = lookup(widget.value.extra_args, "color", null)
        font_size = lookup(widget.value.extra_args, "font_size", null)
        text_align = lookup(widget.value.extra_args, "text_align", null)
      }
    }
  }

  dynamic "widget" {
    for_each = var.fd_note_widgets

    content {
      layout = widget.value.layout
      note_definition {
        content = widget.value.content
        background_color = lookup(widget.value.extra_args, "background_color", null)
        font_size = lookup(widget.value.extra_args, "font_size", null)
        show_tick = lookup(widget.value.extra_args, "show_tick", null)
        text_align = lookup(widget.value.extra_args, "text_align", null)
        tick_edge = lookup(widget.value.extra_args, "tick_edge", null)
        tick_pos = lookup(widget.value.extra_args, "tick_pos", null)
      }
    }
  }

  dynamic "widget" {
    for_each = var.fd_query_value_widgets

    content {
      layout = widget.value.layout
      query_value_definition {
        autoscale = lookup(widget.value.extra_args, "autoscale", false)
        custom_unit = lookup(widget.value.extra_args, "custom_unit", null)
        precision = lookup(widget.value.extra_args, "precision", 0)

        title = lookup(widget.value.extra_args, "title", null)
        title_align = lookup(widget.value.extra_args, "title_align", null)
        title_size = lookup(widget.value.extra_args, "title_size", null)

        request {
          q = widget.value.request.q
          aggregator = widget.value.request.aggregator

          dynamic "conditional_formats" {
            for_each = widget.value.request.conditional_formats

            content {
              comparator = conditional_formats.value.comparator
              value = conditional_formats.value.value
              palette = conditional_formats.value.palette
            }
          }
        }
      }
    }
  }

  dynamic "widget" {
    for_each = var.fd_image_widgets

    content {
      layout = widget.value.layout
      image_definition {
        url = widget.value.url
        sizing = lookup(widget.value.extra_args, "sizing", null)
        margin = lookup(widget.value.extra_args, "margin", null)
      }
    }
  }
}
