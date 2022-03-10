resource "aws_iam_role" "sfx_firehose_role" {
  name               = "splunk-metric-streams-s3-${data.aws_region.current.name}"
  description        = "A role for Kinesis Firehose including the permissions to store failed requests in S3 and output logs"
  assume_role_policy = data.aws_iam_policy_document.sfx_firehose_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "sfx_firehose_policy_attach" {
  role       = aws_iam_role.sfx_firehose_role.name
  policy_arn = aws_iam_policy.sfx_firehose_policy.arn
}

resource "aws_iam_role" "sfx_cloudwatch_role" {
  name               = "splunk-metric-streams-${data.aws_region.current.name}"
  description        = "A role that allows CloudWatch MetricStreams to publish to Kinesis Firehose"
  assume_role_policy = data.aws_iam_policy_document.sfx_cloudwatch_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "sfx_cloudwatch_policy_attach" {
  role       = aws_iam_role.sfx_cloudwatch_role.name
  policy_arn = aws_iam_policy.sfx_cloudwatch_policy.arn
}
