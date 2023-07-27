provider "google" {
  project     = "freetrial-390703"
  region      = "us-central1"  # Change to your desired region
}

resource "google_monitoring_alert_policy" "db_creation_alert" {
  display_name = "DB Creation Alert"
  combiner     = "OR"
  conditions {
    display_name = "test condition"
    condition_matched_log {
      filter     = "resource.type=\"cloudsql_database\" AND protoPayload.methodName=\"cloudsql.instances.create\""
      }
    }

  alert_strategy {
    notification_rate_limit {
      period = "600s"
    }
    auto_close = "1800s"
  }
  notification_channels = [
    google_monitoring_notification_channel.email_notification.id
  ]

  user_labels = {
    foo = "bar"
  }  
}
