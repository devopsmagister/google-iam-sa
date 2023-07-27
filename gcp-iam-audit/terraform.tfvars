#https://cloud.google.com/logging/docs/audit/services

project_id = "freetrial-390703"


audit_configs = {
  enable = true 
  config = [
  {
    service = "accessapproval.googleapis.com"
    audit_log_configs = [
      {
        log_type = "DATA_READ"
      },
      {
        log_type = "DATA_WRITE"
      },
      {
        log_type = "ADMIN_READ"
      }
    ]
  },
  {
    service = "iam.googleapis.com"
    audit_log_configs = [
      {
        log_type = "DATA_READ"
      },
      {
        log_type = "DATA_WRITE"
      },
      {
        log_type = "ADMIN_READ"
      }
    ]
  },
  {
    service = "compute.googleapis.com"
    audit_log_configs = [
      {
        log_type = "DATA_READ"
      },
      {
        log_type = "DATA_WRITE"
      },
      {
        log_type = "ADMIN_READ"
      }
    ]
  }
]
}