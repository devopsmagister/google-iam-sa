# Define notification channels (e.g., email) to receive alerts
resource "google_monitoring_notification_channel" "email_notification" {
  display_name = "Email Notification"
  type         = "email"
  labels = {
    email_address = "test@gmail.com"  # Replace with your email address
  }
}