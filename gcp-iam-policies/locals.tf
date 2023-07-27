
locals {
  policy_details = { for x in var.policy_details : x.display_name => merge(
    {
      combiner       = try(x.combiner, "OR")
      conditions     = try(x.conditions, [])
      alert_strategy = try(x.alert_strategy, [])
      user_labels    = try(x.user_labels, null)
    }
    )

  }
}
