variable "organization_name" {
  description = "Organization Name to use in labeling"
  default     = ""
}
variable "org_unit_name" {
  description = "Organization Unit Name to use with labeling"
  default     = ""
}

variable "environment_type" {
  description = "Environment type for use with labeling"
  default     = ""
}


variable "organization_email" {
  description = "Organization e-mail for root id"
}

variable "organization_allow_billing_access" {
  description = "Allow Billing access to organization structure sub-accounts"
  default     = false
}

variable "organization_role" {
  default = "OrganizationAllowAllAccess"
}

variable "aws_region" {
  default = "us-east-1"
}
