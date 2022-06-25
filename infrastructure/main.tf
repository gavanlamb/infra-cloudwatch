resource "aws_kms_key" "cloudwatch" {
  description = "KMS key for cloudwatch"
  deletion_window_in_days = 10
  policy = data.aws_iam_policy_document.cloudwatch.json
}

resource "aws_kms_alias" "cloudwatch" {
  name = "alias/expensely/${lower(var.environment)}/cloudwatch"
  target_key_id = aws_kms_key.cloudwatch.key_id
}

data "aws_iam_policy_document" "cloudwatch" {
  statement {
    effect = "Allow"
    actions = [
      "kms:*"
    ]
    resources = [
      "*"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
  }
  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = [
      "*"
    ]
    principals {
      type = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = [
        "monitoring.${var.region}.amazonaws.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = [
        data.aws_caller_identity.current.account_id
      ]
    }
  }
  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = [
      "*"
    ]
    principals {
      type = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "ArnLike"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values   = [
        "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:*"
      ]
    }
  }
}