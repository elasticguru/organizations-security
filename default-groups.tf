# This one extracts the Account ID from the API request
data "aws_caller_identity" "current" {
}

## Admin Group with billing
resource "aws_iam_group" "superadmin" {
  name = "superadmin"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "superadmin" {
  group      = aws_iam_group.superadmin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "billing" {
  group      = aws_iam_group.superadmin.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}

## Admin Group without billing
resource "aws_iam_group" "accountadmin" {
  name = "accountadmin"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "accountadmin" {
  group      = aws_iam_group.accountadmin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

## Sys-admin Group full access to Lambda CloduWatch S3 API IAM & EC2
resource "aws_iam_group" "sysadmin" {
  name = "sysadmin"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "dbadmin" {
  group      = aws_iam_group.sysadmin.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/DatabaseAdministrator"
}

resource "aws_iam_group_policy_attachment" "sysadmin" {
  group      = aws_iam_group.sysadmin.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/SystemAdministrator"
}

resource "aws_iam_group_policy_attachment" "netadmin" {
  group      = aws_iam_group.sysadmin.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/NetworkAdministrator"
}

resource "aws_iam_group_policy_attachment" "iamfull" {
  group      = aws_iam_group.sysadmin.name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

resource "aws_iam_group_policy_attachment" "apifull" {
  group      = aws_iam_group.sysadmin.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator"
}

