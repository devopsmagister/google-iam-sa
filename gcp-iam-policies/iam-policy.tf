provider "google" {
  project = "freetrial-390703"
  region  = "us-central1" # Change to your desired region
}



resource "google_monitoring_alert_policy" "db_creation_alert" {
  for_each     = local.policy_details
  display_name = each.key
  combiner     = each.value.combiner
  dynamic "conditions" {
    for_each = { for x in each.value.conditions : x.condition_display_name => x }
    content {
      display_name = conditions.key

      dynamic "condition_matched_log" {
        for_each = { for x in try(conditions.value.condition_matched_log, []) : x.filter => x }
        content {
          filter = conditions.key
        }
      }

      dynamic "condition_threshold" {
        for_each = { for x in try(conditions.value.condition_threshold, []) : x.filter => x }
        content {
          filter          = condition_threshold.key
          duration        = condition_threshold.value.duration
          comparison      = condition_threshold.value.comparison
          threshold_value = try(condition_threshold.value.threshold_value, null)
          dynamic "aggregations" {
            for_each = { for x in try(condition_threshold.value.aggregations, []) : x.per_series_aligner => x }
            content {
              alignment_period   = try(aggregations.value.alignment_period, null)
              per_series_aligner = try(aggregations.value.per_series_aligner, null)
            }
          }
        }
      }

      dynamic "condition_absent" {
        for_each = { for x in try(conditions.value.condition_absent, []) : x.filter => x }
        content {
          filter   = condition_absent.key
          duration = condition_absent.value.duration
          dynamic "aggregations" {
            for_each = { for x in try(condition_absent.value.aggregations, []) : x.filter => x }
            content {
              alignment_period   = try(aggregations.value.alignment_period, null)
              per_series_aligner = try(aggregations.value.per_series_aligner, null)
            }
          }
        }
      }
    }
  }

  dynamic "alert_strategy" {
    for_each = { for x in try(each.value.alert_strategy, []) : x.auto_close => x }
    content {

      notification_rate_limit {
        period = alert_strategy.value.period
      }
      auto_close = alert_strategy.key
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.email_notification.id
  ]

  user_labels = {
    foo = "bar"
  }
}
