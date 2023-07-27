variable "policy_details" {
  type = list(object({
    display_name = string
    combiner     = string
    conditions = list(object({
      condition_display_name = string
      condition_matched_log = optional(list(object({
        filter = string
      })), [])
      condition_threshold = optional(list(object({
        filter          = string
        duration        = string
        comparison      = string
        threshold_value = optional(number, null)
        aggregations = optional(list(object({
          alignment_period   = optional(string, null)
          per_series_aligner = optional(string, null)
        })), [])
      })), [])
      condition_absent = optional(list(object({
        filter          = string
        duration        = string
        comparison      = string
        threshold_value = optional(number, null)
        aggregations = optional(list(object({
          alignment_period   = optional(string, null)
          per_series_aligner = optional(string, null)
        })), [])
      })), [])

    }))
    alert_strategy = optional(list(map(string)), [])
    user_labels    = map(string)

  }))
  default     = []
  description = "description"
}
