service_account = {
  "devops-magister-account1" = {
    display_name  = "devops-magister-account"
    project       = "freetrial-390703"
    disabled      = false
    description   = "devops-magister-account-1"
    # rotation_days = 5
    # key_enabled = true
  },
  "devops-magister-account2" = {
    display_name  = "devops-magister-account2"
    project       = "freetrial-390703"
    disabled      = false
    description   = "devops-magister-account-1"
    # rotation_days = 10
    # key_enabled = true

  },
  "devops-magister-account3" = {
    account_id   = "devops-magister-account3"
    display_name = "devops-magister-accoun3"
    project      = "freetrial-390703"
    # disabled     = false
    description  = "devops-magister-account-1"
    rotation_days = 20
    key_enabled = true
  }
}

iam_binding = {
  "roles/iam.serviceAccountUser" = [
    "devops-magister-account2",
    "devops-magister-account3"
  ],
  "roles/serviceusage.apiKeysViewer" = [
    "devops-magister-account1",
    "devops-magister-account3"
  ],
  "roles/gkemulticloud.viewer" = [
    "devops-magister-account1",
    "devops-magister-account2"
  ],

}