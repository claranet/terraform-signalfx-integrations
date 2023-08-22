data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket" "sfx_metric_stream" {
  bucket = "splunk-metric-streams-s3-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
}

resource "aws_cloudwatch_log_group" "sfx_metric_stream" {
  name              = "/aws/kinesisfirehose/splunk-metric-streams-${data.aws_region.current.name}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
}

resource "aws_cloudwatch_log_stream" "http_log_stream" {
  name           = "HttpEndpointDelivery"
  log_group_name = aws_cloudwatch_log_group.sfx_metric_stream.name
}

resource "aws_kinesis_firehose_delivery_stream" "sfx_metric_stream" {
  name        = "splunk-metric-streams-${data.aws_region.current.name}"
  destination = "http_endpoint"

  http_endpoint_configuration {
    url                = "${var.sfx_ingest_url}/v1/cloudwatch_metric_stream"
    name               = "SignalFx"
    access_key         = var.sfx_access_token
    buffering_size     = 1
    buffering_interval = 60
    role_arn           = aws_iam_role.sfx_firehose_role.arn
    s3_backup_mode     = "FailedDataOnly"

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = aws_cloudwatch_log_group.sfx_metric_stream.name
      log_stream_name = aws_cloudwatch_log_stream.http_log_stream.name
    }

    request_configuration {
      content_encoding = "GZIP"
    }

    s3_configuration {
      role_arn           = aws_iam_role.sfx_firehose_role.arn
      bucket_arn         = aws_s3_bucket.sfx_metric_stream.arn
      buffering_size     = 1
      buffering_interval = 60
      compression_format = "GZIP"
    }
  }

  tags = {
    "splunk-metric-streams-firehose" = "${data.aws_region.current.name}"
  }
}
