resource "aws_iam_user" "superadmin" {
  for_each = {
      for value in var.superadmin_user_list : value.name => value
    }

  name          = each.key
  path          = "/"
  force_destroy = true

  tags = merge(
    local.common_tags,
    {
      "Name" = each.key
    },
  )
}

resource "aws_iam_user_login_profile" "superadmin" {
  depends_on = [ aws_iam_user.superadmin ]
  for_each = {
      for value in var.superadmin_user_list : value.name => value
    }

  user                    = each.key
  pgp_key                 = var.iam_pgp_key
  password_reset_required = true

  # This is not the best situation but prevents resource regeneration
  # that can mess up an the existing imported users
  lifecycle {
    ignore_changes = [
      pgp_key,
      encrypted_password,
      key_fingerprint,
      password_length,
      password_reset_required,
    ]
  }
}

# API KEYS
resource "aws_iam_access_key" "superadmin" {
  depends_on = [ aws_iam_user.superadmin ]
  for_each = {
      for value in var.superadmin_user_list: 
        value.name => value
        if value.has_api_key
    }

  user    = each.key
  pgp_key = var.iam_pgp_key
}

resource "aws_iam_group_membership" "superadmin" {
  depends_on = [ aws_iam_user.superadmin ]

  count = length(var.superadmin_user_list) > 0 ? 1 : 0
  name  = "admins-superadmin-membership-${count.index}"

  users = var.superadmin_user_list.*.name

  group = aws_iam_group.superadmin.name
}

##
# Sysadmin config
resource "aws_iam_user" "sysadmin" {
  for_each = {
      for value in var.sysadmin_user_list : value.name => value
    }

  name          = each.key
  path          = "/"
  force_destroy = true

  tags = merge(
    local.common_tags,
    {
      "Name" = each.key
    },
  )
}

resource "aws_iam_user_login_profile" "sysadmin" {
  depends_on = [ aws_iam_user.sysadmin ]

  for_each = {
      for value in var.sysadmin_user_list : value.name => value
    }

  user                    = each.key
  pgp_key                 = var.iam_pgp_key
  password_reset_required = true

  # This is not the best situation but prevents resource regeneration
  # that can mess up an the existing imported users
  lifecycle {
    ignore_changes = [
      pgp_key,
      encrypted_password,
      key_fingerprint,
      password_length,
      password_reset_required,
    ]
  }
}

resource "aws_iam_group_membership" "sysadmin" {
  depends_on = [ aws_iam_user.sysadmin ]
  count = length(var.sysadmin_user_list) > 0 ? 1 : 0

  name  = "admins-sysadmin-membership-${count.index}"

  users = var.sysadmin_user_list.*.name

  group = aws_iam_group.sysadmin.name
}

##
# Plain Admin config
resource "aws_iam_user" "plainadmin" {
  for_each = {
      for value in var.plainadmin_user_list : value.name => value
    }

  name          = each.key
  path          = "/"
  force_destroy = true

  tags = merge(
    local.common_tags,
    {
      "Name" = each.key
    },
  )
}

resource "aws_iam_user_login_profile" "plainadmin" {
  depends_on = [ aws_iam_user.plainadmin ]

  for_each = {
      for value in var.plainadmin_user_list : value.name => value
    }

  user                    = each.key
  pgp_key                 = var.iam_pgp_key
  password_reset_required = true

  # This is not the best situation but prevents resource regeneration
  # that can mess up an the existing imported users
  lifecycle {
    ignore_changes = [
      pgp_key,
      encrypted_password,
      key_fingerprint,
      password_length,
      password_reset_required,
    ]
  }
}

resource "aws_iam_group_membership" "plainadmin" {
  depends_on = [ aws_iam_user.plainadmin ]
  count = length(var.plainadmin_user_list) > 0 ? 1 : 0

  name  = "admins-admin-membership-${count.index}"

  users = var.plainadmin_user_list.*.name

  group = aws_iam_group.accountadmin.name
}
