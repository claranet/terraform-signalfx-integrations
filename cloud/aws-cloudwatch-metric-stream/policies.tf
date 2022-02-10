data "aws_iam_policy_document" "sfx_firehose_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "sfx_firehose_policy" {
  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
    ]

    effect = "Allow"

    resources = [
      aws_s3_bucket.sfx_metric_stream.arn,
      format("%s/*", aws_s3_bucket.sfx_metric_stream.arn),
    ]
  }

  statement {
    actions = [
      "logs:PutLogEvents",
    ]

    effect = "Allow"

    resources = [
      format("%s:*", aws_cloudwatch_log_group.sfx_metric_stream.arn),
    ]
  }
}

resource "aws_iam_policy" "sfx_firehose_policy" {
  name   = "splunk-metric-streams-firehose-${data.aws_region.current.name}"
  policy = data.aws_iam_policy_document.sfx_firehose_policy.json
}

data "aws_iam_policy_document" "sfx_cloudwatch_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["streams.metrics.cloudwatch.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "sfx_cloudwatch_policy" {
  statement {
    actions = [
      "firehose:PutRecord",
      "firehose:PutRecordBatch"
    ]

    effect = "Allow"

    resources = [
      aws_kinesis_firehose_delivery_stream.sfx_metric_stream.arn,
    ]
  }
}

resource "aws_iam_policy" "sfx_cloudwatch_policy" {
  name   = "splunk-metric-streams-cloudwatch-${data.aws_region.current.name}"
  policy = data.aws_iam_policy_document.sfx_cloudwatch_policy.json
}
