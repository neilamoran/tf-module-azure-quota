data "http" "current_quota" {
  url = join("/", [
    "https://management.azure.com",
    "subscriptions",
    var.subscription_id,
    "providers/Microsoft.Capacity/resourceProviders",
    var.provider_id,
    "locations",
    var.location,
    "serviceLimits",
    var.sku_name,
    "?api-version=2020-10-25"
  ])

  # Optional request headers
  request_headers = {
    Accept        = "application/json"
    Authorization = local.access_token
  }

  lifecycle {
    postcondition {
      condition     = contains([200, 201, 204], self.status_code)
      error_message = "Status code invalid"
    }
  }
}

data "http" "update_quota" {
  count = var.action == "Set" ? 1 : 0

  url = join("/", [
    "https://management.azure.com",
    "subscriptions",
    var.subscription_id,
    "providers/Microsoft.Capacity/resourceProviders",
    var.provider_id,
    "locations",
    var.location,
    "serviceLimits",
    var.sku_name,
    "?api-version=2020-10-25"
  ])

  # Optional request headers
  request_headers = {
    Accept        = "application/json"
    Authorization = local.access_token
  }

  lifecycle {
    postcondition {
      condition     = contains([200, 201, 204], self.status_code)
      error_message = "Status code invalid"
    }
  }
  depends_on = [
    null_resource.set_quota
  ]
}

data "external" "access_token" {
  program = ["pwsh", "-c", templatefile("${path.module}/scripts/Get-AccessToken.az", {
    subscription_id = var.subscription_id
  })]
}
