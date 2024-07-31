resource "aws_iam_role" "sfx_role" {
  name                 = "SignalFxIntegration${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
  description          = "SignalFx integration to read out data and send it to SignalFx's AWS account"
  assume_role_policy   = data.aws_iam_policy_document.sfx_policy_doc.json
  permissions_boundary = var.sfx_role_permissions_boundary
}

resource "aws_iam_role_policy_attachment" "sfx_policy_attach" {
  role       = aws_iam_role.sfx_role.name
  policy_arn = aws_iam_policy.sfx_policy.arn
}

resource "aws_iam_role_policy_attachment" "sfx_metric_streams_policy_attach" {
  count      = var.create_metric_streams_iam ? 1 : 0
  role       = aws_iam_role.sfx_role.name
  policy_arn = aws_iam_policy.sfx_metric_streams_policy[0].arn
}

# workaround to be sure the policy is really applied to the role before to try to create the integration
resource "time_sleep" "policy_availability" {
  depends_on = [
    aws_iam_role_policy_attachment.sfx_policy_attach,
    aws_iam_role_policy_attachment.sfx_metric_streams_policy_attach,
  ]

  create_duration = "15s"
}

resource "aws_iam_role_policy_attachment" "sfx_logs_policy_attach" {
  count      = var.create_logs_iam ? 1 : 0
  role       = aws_iam_role.sfx_role.name
  policy_arn = aws_iam_policy.sfx_logs_policy[0].arn
}

# workaround to be sure the policy is really applied to the role before to try to create the integration
resource "time_sleep" "logs_policy_availability" {
  depends_on = [
    aws_iam_role_policy_attachment.sfx_policy_attach,
    aws_iam_role_policy_attachment.sfx_logs_policy_attach,
  ]

  create_duration = "15s"
}

