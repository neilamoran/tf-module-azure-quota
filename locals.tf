locals {
  access_token = sensitive(join(" ", [
    data.external.access_token.result.Type,
    data.external.access_token.result.Token
  ]))

  response = jsondecode(data.http.current_quota.response_body)
}