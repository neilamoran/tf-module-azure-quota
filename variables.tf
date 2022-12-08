variable "subscription_id" {
  type        = string
  description = "Subscription ID in which to get/set quota limit"
}

variable "provider_id" {
  type        = string
  description = "The Azure resource provider ID (only \"Microsoft.Compute\" is currently supported)"
  default     = "Microsoft.Compute"
}

variable "location" {
  type        = string
  description = "The Azue region for which to set quota limit"
}

variable "sku_name" {
  type        = string
  description = "The SKU Family name for which to set quota limit - can be retrieved from https://learn.microsoft.com/en-us/rest/api/compute/resource-skus/list?tabs=HTTP"
}

variable "action" {
  type        = string
  description = "Allowed values of \"Get\" or \"Set\""
  default     = "Get"
}

variable "update_limit" {
  type        = number
  description = "The updated value for the quota limit to set"
  default     = 0
}