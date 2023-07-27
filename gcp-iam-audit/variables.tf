variable "audit_configs" {
  type        = any
  description = "(Optional) A list of Audit Logs configurations."
  default     = []
}

variable "project_id" {
  type        = string
  default     = ""
  description = "description"
}

# variable enable {
#   type        = bool
#   default     = true
# }
