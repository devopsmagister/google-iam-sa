terraform {
  required_version = "> 1.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.70.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">=4.70.1"
    }
  }
}

locals {
  service_account = { for x in var.service_account : x.account_id => merge(
    {
      account_id    = x.account_id
      display_name  = try(x.display_name, x.account_id)
      project       = try(x.project, null) == null ? var.project : x.project
      disabled      = try(x.disabled, false)
      description   = try(x.description, x.account_id)
      rotation_days = try(x.rotation_days, 90)
      key_enabled   = try(x.key_enabled, false)
    }
    )

  }
}

resource "google_service_account" "service_account" {
  for_each     = { for x, y in local.service_account : x => y }
  account_id   = each.value.account_id
  display_name = each.value.display_name
  project      = each.value.project
  disabled     = each.value.disabled
  description  = each.value.description
}

resource "google_project_iam_binding" "project" {
  for_each = var.iam_binding
  project  = google_service_account.service_account[element(each.value, 0)].project
  role     = each.key

  members = [
    for id in range(0, length(each.value)) : google_service_account.service_account[element(each.value, id)].member
  ]
}

# resource "time_rotating" "key_rotation" {
#   for_each = { for x, y in local.service_account : x => y.rotation_days if y.key_enabled }

#   rotation_days = each.value
# }

# resource "google_service_account_key" "mkey" {
#   for_each = { for x, y in local.service_account : x => y if y.key_enabled }

#   service_account_id = google_service_account.service_account[each.key].name

#   keepers = {
#     rotation_time = time_rotating.key_rotation[each.key].rotation_rfc3339
#   }
# }

output "service_account" {
  value = google_service_account.service_account
}

resource "time_rotating" "key_rotation" {
  for_each = var.service_account_keys

  rotation_days = each.value
}

resource "google_service_account_key" "mkey" {
  for_each = var.service_account_keys

  service_account_id = google_service_account.service_account[each.key].name

  keepers = {
    rotation_time = time_rotating.key_rotation[each.key].rotation_rfc3339
  }
}

