output "current_quota" {
  value = local.response
}

output "update_quota" {
  value = var.action == "Set" ? jsondecode(data.http.update_quota[0].response_body) : null
}
