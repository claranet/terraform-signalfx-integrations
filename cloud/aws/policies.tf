resource "aws_iam_policy" "sfx_policy" {
  name        = "SignalFxIntegrationPolicy${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
  description = "AWS Policy"
  policy      = <<EOF
{
"Version": "2012-10-17",
"Statement": [
	{
		"Action": [
			"apigateway:GET",
			"autoscaling:Describe*",
			"budgets:ViewBudget",
			"cloudfront:Get*",
			"cloudfront:List*",
			"cloudtrail:DescribeTrails",
			"cloudtrail:GetTrailStatus",
			"cloudwatch:Describe*",
			"cloudwatch:Get*",
			"cloudwatch:List*",
			"codedeploy:List*",
			"codedeploy:BatchGet*",
			"directconnect:Describe*",
			"dynamodb:List*",
			"dynamodb:Describe*",
			"ec2:Describe*",
			"ecs:Describe*",
			"ecs:List*",
			"elasticache:Describe*",
			"elasticache:List*",
			"elasticfilesystem:DescribeFileSystems",
			"elasticfilesystem:DescribeTags",
			"elasticloadbalancing:Describe*",
			"elasticloadbalancing:List*",
			"elasticmapreduce:List*",
			"elasticmapreduce:Describe*",
			"es:List*",
			"es:Describe*",
			"health:DescribeEvents",
			"health:DescribeEventDetails",
			"health:DescribeAffectedEntities",
			"kinesis:List*",
			"kinesis:Describe*",
			"lambda:Get*",
			"lambda:List*",
			"logs:Get*",
			"logs:Describe*",
			"logs:FilterLogEvents",
			"logs:TestMetricFilter",
			"logs:PutSubscriptionFilter",
			"logs:DeleteSubscriptionFilter",
			"logs:DescribeSubscriptionFilters",
			"organizations:Describe*",
			"rds:Describe*",
			"rds:List*",
			"redshift:Describe*",
			"route53:List*",
			"s3:GetBucketLogging",
			"s3:GetBucketLocation",
			"s3:GetBucketNotification",
			"s3:GetBucketTagging",
			"s3:List*",
			"ses:Get*",
			"sns:List*",
			"sns:Publish",
			"sqs:List*",
			"sqs:Get*",
			"support:*",
			"tag:GetResources",
			"tag:GetTagKeys",
			"tag:GetTagValues",
			"xray:BatchGetTraces",
			"xray:GetTraceSummaries"
			],
		"Effect": "Allow",
		"Resource": "*"
		}
	]
}
EOF
}

data "aws_iam_policy_document" "sfx_policy_doc" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [signalfx_aws_external_integration.aws_integration_external.signalfx_aws_account]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [signalfx_aws_external_integration.aws_integration_external.external_id]
    }
  }
}
