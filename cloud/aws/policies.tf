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
            "autoscaling:DescribeAutoScalingGroups",
            "budgets:ViewBudget",
            "cloudfront:GetDistributionConfig",
            "cloudfront:ListDistributions",
            "cloudfront:ListTagsForResource",
            "cloudwatch:DescribeAlarms",
            "cloudwatch:GetMetricData",
            "cloudwatch:GetMetricStatistics",
            "cloudwatch:ListMetrics",
            "codedeploy:BatchGet*",
            "codedeploy:List*",
            "directconnect:DescribeConnections",
            "dynamodb:DescribeTable",
            "dynamodb:ListTables",
            "dynamodb:ListTagsOfResource",
            "ec2:DescribeInstances",
            "ec2:DescribeInstanceStatus",
            "ec2:DescribeRegions",
            "ec2:DescribeReservedInstances",
            "ec2:DescribeReservedInstancesModifications",
            "ec2:DescribeTags",
            "ec2:DescribeVolumes",
            "ecs:DescribeClusters",
            "ecs:DescribeServices",
            "ecs:DescribeTasks",
            "ecs:ListClusters",
            "ecs:ListServices",
            "ecs:ListTagsForResource",
            "ecs:ListTaskDefinitions",
            "ecs:ListTasks",
            "elasticache:DescribeCacheClusters",
            "elasticfilesystem:DescribeFileSystems",
            "elasticfilesystem:DescribeTags",
            "elasticloadbalancing:DescribeLoadBalancerAttributes",
            "elasticloadbalancing:DescribeLoadBalancers",
            "elasticloadbalancing:DescribeTags",
            "elasticloadbalancing:DescribeTargetGroups",
            "elasticmapreduce:DescribeCluster",
            "elasticmapreduce:ListClusters",
            "es:DescribeElasticsearchDomain",
            "es:ListDomainNames",
            "health:DescribeAffectedEntities",
            "health:DescribeEventDetails",
            "health:DescribeEvents",
            "kinesis:DescribeStream",
            "kinesis:ListShards",
            "kinesis:ListStreams",
            "kinesis:ListTagsForStream",
            "lambda:GetAlias",
            "lambda:ListFunctions",
            "lambda:ListTags",
            "logs:DeleteSubscriptionFilter",
            "logs:DescribeLogGroups",
            "logs:DescribeSubscriptionFilters",
            "logs:PutSubscriptionFilter",
            "organizations:DescribeOrganization",
            "rds:DescribeDBClusters",
            "rds:DescribeDBInstances",
            "rds:ListTagsForResource",
            "redshift:DescribeClusters",
            "redshift:DescribeLoggingStatus",
            "route53:List*",
            "s3:GetBucketLocation",
            "s3:GetBucketLogging",
            "s3:GetBucketNotification",
            "s3:GetBucketTagging",
            "s3:ListAllMyBuckets",
            "s3:ListBucket",
            "s3:PutBucketNotification",
            "sqs:GetQueueAttributes",
            "sqs:ListQueues",
            "sqs:ListQueueTags",
            "states:ListStateMachines",
            "tag:GetResources",
            "tag:GetTagKeys",
            "tag:GetTagValues",
            "workspaces:DescribeWorkspaces",
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

resource "aws_iam_policy" "sfx_metric_streams_policy" {
  count       = var.create_metric_streams_iam ? 1 : 0
  name        = "SignalFxIntegrationMetricStreamsPolicy${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
  description = "SignalFx AWS Policy for ingesting Cloudwatch Metric Streams"
  policy      = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
        "Action": [
            "cloudwatch:ListMetricStreams",
            "cloudwatch:GetMetricStream",
            "cloudwatch:PutMetricStream",
            "cloudwatch:DeleteMetricStream",
            "cloudwatch:StartMetricStreams",
            "cloudwatch:StopMetricStreams",
            "iam:PassRole"
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
