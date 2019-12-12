output "super_admins" {
  value = [ for admin in aws_iam_user_login_profile.superadmin :
    {
      user_name = admin.user
      encrypted_password = admin.encrypted_password
    }
  ] 
}

output "super_admins_keys" {
  value = [ for admin in aws_iam_access_key.superadmin :
    {
      user_name = admin.user
      aws_key_id = admin.id
      aws_secret_key = admin.encrypted_secret
    }
  ] 
}

output "sys_admins" {
  value = [ for admin in aws_iam_user_login_profile.sysadmin :
    {
      user_name = admin.user
      encrypted_password = admin.encrypted_password
    }
  ] 
}

output "local_admins" {
  value = [ for admin in aws_iam_user_login_profile.plainadmin :
    {
      user_name = admin.user
      encrypted_password = admin.encrypted_password
    }
  ] 
}
