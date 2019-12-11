locals {
  name_tag                   = "${var.organization_name} ${var.org_unit_name} ${var.environment_type}"
  object_name_tag            = "${var.organization_name}${var.org_unit_name}${var.environment_type}"

  compound_organization_name = "${var.organization_name}-${var.org_unit_name}"
  compound_environment_name  = "${var.organization_name}-${var.org_unit_name}-${var.environment_type}"

  full_organization_name = "${var.org_unit_name == "" ? var.organization_name : local.compound_organization_name}"
  environment_name  = var.org_unit_name == "" ? "${var.organization_name}-${var.environment_type}" : local.compound_environment_name

  common_tags = {
    organization-full-name = "${var.organization_name} ${var.org_unit_name} ${var.environment_type}"
    application-type       = "${var.environment_type}"
    organization-unit      = "${var.org_unit_name}"
    organization           = "${var.organization_name}"
  }
}
