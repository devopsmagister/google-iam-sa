#https://cloud.google.com/iam/docs/audit-logging
#gcloud auth application-default login


locals {
  audit_configs_map = { for config in var.audit_configs.config : config.service => config }
}

resource "google_project_iam_audit_config" "default" {
  for_each = var.audit_configs.enable ? local.audit_configs_map : {}

  project = var.project_id

  service = each.value.service

  dynamic "audit_log_config" {
    for_each = each.value.audit_log_configs

    content {
      log_type         = audit_log_config.value.log_type
      exempted_members = try(audit_log_config.value.exempted_members, null)
    }
  }
}

