resource "null_resource" "set_quota" {
  count = var.action == "Set" ? 1 : 0

  triggers = {
    update = var.update_limit
  }

  provisioner "local-exec" {
    interpreter = ["powershell", "-c"]
    command = templatefile("${path.module}/scripts/Set-SkuQuota.az", {
      access_token    = local.access_token
      subscription_id = var.subscription_id
      location        = var.location
      provider_id     = var.provider_id
      sku_name        = var.sku_name
      current_quota   = data.http.current_quota.response_body
      update_limit    = var.update_limit
    })
  }
}