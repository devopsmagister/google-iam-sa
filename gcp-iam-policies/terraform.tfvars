policy_details = [
  {
    display_name = "DB Creation Alert"
    combiner     = "OR"
    conditions = [
      {
        condition_display_name = "test connections"
        condition_matched_log = [{
          filter = "resource.type=\"cloudsql_database\" AND protoPayload.methodName=\"cloudsql.instances.create\""
        }]
      }
    ]
    alert_strategy = [{
      period     = "600s"
      auto_close = "1800s"
    }]
    user_labels = {
      foo = "bar"
    }
  },
  {
    display_name = "DB Creation Alert2"
    combiner     = "OR"
    conditions = [
      {
        condition_display_name = "test connections"
        condition_threshold = [{
          filter          = "resource.type = \"cloudsql_database\" AND resource.labels.database_id = \"freetrial-390703:test\" AND metric.type = \"cloudsql.googleapis.com/database/cpu/utilization\""
          duration        = "0s"
          comparison      = "COMPARISON_GT"
          threshold_value = "70"
          aggregations = [{
            alignment_period   = "60s"
            per_series_aligner = "ALIGN_PERCENT_CHANGE"
          }]
        }]
      }
    ]
    # alert_strategy = []
    user_labels = {
      foo = "bar"
    }
  }
]