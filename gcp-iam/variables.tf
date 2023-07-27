variable "service_account_keys" {
  type = map(string)
}

variable "service_account" {
  type = list(object({
    account_id    = string
    display_name  = optional(string, null)
    project       = optional(string, null)
    disabled      = optional(bool, false)
    description   = optional(string, null)
    rotation_days = optional(number, 90)
    key_enabled   = optional(bool, false)
  }))
}

variable "iam_binding" {
  type = map(list(string))
}

variable "project" {
  type    = string
  default = ""
}

