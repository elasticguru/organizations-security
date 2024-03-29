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

variable "iam_pgp_key" {
  default = "keybase:berahac"
}

variable "superadmin_user_list" {
  type    = list(object({
    name = string,
    has_api_key = bool
  }))
  default = []
}

variable "plainadmin_user_list" {
  type    = list(object({
    name = string,
    has_api_key = bool
  }))
  default = []
}

variable "sysadmin_user_list" {
  type    = list(object({
    name = string,
    has_api_key = bool
  }))
  default = []
}

