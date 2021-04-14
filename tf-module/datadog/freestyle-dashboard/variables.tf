terraform {
  backend "s3" {}
}

variable "fd_title" {
  type = string
}

variable "fd_description" {
  type = string
  default = null
}

variable "fd_free_text_widgets" {
  type = list(object({
    layout = object({
      height = number
      width = number
      x = number
      y = number
    })
    text = string
    extra_args = map(string)
  }))
  default = []
}

variable "fd_note_widgets" {
  type = list(object({
    layout = object({
      height = number
      width = number
      x = number
      y = number
    })
    content = string
    extra_args = map(string)
  }))
  default = []
}

variable "fd_query_value_widgets" {
  type = map(object({
    layout = object({
      height = number
      width = number
      x = number
      y = number
    })
    request = object({
      q = string
      aggregator = string
      conditional_formats = list(object({
        comparator = string
        value = string
        palette = string
      }))
    })
    extra_args = map(string)
  }))
  default = {}
}

variable "fd_image_widgets" {
  type = list(object({
    layout = object({
      height = number
      width = number
      x = number
      y = number
    })
    url = string
    extra_args = map(string)
  }))
  default = []
}
