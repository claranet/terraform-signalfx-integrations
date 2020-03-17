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
			"cloudfront:GetDistributionConfig",
			"cloudfront:ListDistributions",
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
			"elasticmapreduce:List*",
			"elasticmapreduce:Describe*",
			"es:ListTags",
			"es:ListDomainNames",
			"es:DescribeElasticsearchDomains",
			"health:DescribeEvents",
			"health:DescribeEventDetails",
			"health:DescribeAffectedEntities",
			"kinesis:List*",
			"kinesis:Describe*",
			"lambda:AddPermission",
			"lambda:GetPolicy",
			"lambda:List*",
			"lambda:RemovePermission",
			"logs:Get*",
			"logs:Describe*",
			"logs:FilterLogEvents",
			"logs:TestMetricFilter",
			"logs:PutSubscriptionFilter",
			"logs:DeleteSubscriptionFilter",
			"logs:DescribeSubscriptionFilters",
			"rds:Describe*",
			"rds:List*",
			"redshift:DescribeClusters",
			"redshift:DescribeLoggingStatus",
			"route53:List*",
			"s3:GetBucketLogging",
			"s3:GetBucketLocation",
			"s3:GetBucketNotification",
			"s3:GetBucketTagging",
			"s3:ListAllMyBuckets",
			"s3:PutBucketNotification",
			"ses:Get*",
			"sns:List*",
			"sns:Publish",
			"sqs:ListQueues",
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
      identifiers = [signalfx_aws_external_integration.sfx_integration_external.signalfx_aws_account]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [signalfx_aws_external_integration.sfx_integration_external.external_id]
    }
  }
}
