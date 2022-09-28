#resource "aws_kms_key" "cloudwatch" {
#  description = "KMS key for cloudwatch"
#  deletion_window_in_days = 10
#  policy = data.aws_iam_policy_document.cloudwatch.json
#  enable_key_rotation = true
#  multi_region = true
#}
#
#resource "aws_kms_alias" "cloudwatch" {
#  name = "alias/expensely/cloudwatch"
#  target_key_id = aws_kms_key.cloudwatch.key_id
#}
#
#data "aws_iam_policy_document" "cloudwatch" {
#  statement {
#    effect = "Allow"
#    actions = [
#      "kms:*"
#    ]
#    resources = [
#      "*"
#    ]
#    principals {
#      type = "AWS"
#      identifiers = [
#        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
#      ]
#    }
#  }
#  statement {
#    effect = "Allow"
#    actions = [
#      "kms:Encrypt*",
#      "kms:Decrypt*",
#      "kms:ReEncrypt*",
#      "kms:GenerateDataKey*",
#      "kms:Describe*"
#    ]
#    resources = [
#      "*"
#    ]
#    principals {
#      type = "AWS"
#      identifiers = var.account_ids
#    }
#    condition {
#      test     = "StringEquals"
#      variable = "kms:ViaService"
#      values   = [
#        "monitoring.ap-southeast-2.amazonaws.com",
#        "monitoring.us-east-1.amazonaws.com",
#        "monitoring.us-east-2.amazonaws.com",
#        "monitoring.us-west-2.amazonaws.com"
#      ]
#    }
#  }
#  statement {
#    effect = "Allow"
#    actions = [
#      "kms:Encrypt*",
#      "kms:Decrypt*",
#      "kms:ReEncrypt*",
#      "kms:GenerateDataKey*",
#      "kms:Describe*"
#    ]
#    resources = [
#      "*"
#    ]
#    principals {
#      type = "AWS"
#      identifiers = var.account_ids
#    }
#    condition {
#      test     = "ArnLike"
#      variable = "kms:EncryptionContext:aws:logs:arn"
#      values   = [
#        "arn:aws:logs:::log-group:*"
#      ]
#    }
#  }
#}