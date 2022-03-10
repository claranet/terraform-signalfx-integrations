resource "aws_iam_policy" "sfx_policy" {
  name        = "SignalFxIntegrationPolicy${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
  description = "AWS Policy"
  policy      = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
        "Action": [
            "dynamodb:ListTables",
            "dynamodb:DescribeTable",
            "dynamodb:ListTagsOfResource",
            "ec2:DescribeInstances",
            "ec2:DescribeInstanceStatus",
            "ec2:DescribeVolumes",
            "ec2:DescribeReservedInstances",
            "ec2:DescribeReservedInstancesModifications",
            "ec2:DescribeTags",
            "ec2:DescribeRegions",
            "organizations:DescribeOrganization",
            "cloudwatch:ListMetrics",
            "cloudwatch:GetMetricData",
            "cloudwatch:GetMetricStatistics",
            "cloudwatch:DescribeAlarms",
            "sqs:ListQueues",
            "sqs:GetQueueAttributes",
            "sqs:ListQueueTags",
            "elasticmapreduce:ListClusters",
            "elasticmapreduce:DescribeCluster",
            "kinesis:ListShards",
            "kinesis:ListStreams",
            "kinesis:DescribeStream",
            "kinesis:ListTagsForStream",
            "rds:DescribeDBInstances",
            "rds:ListTagsForResource",
            "elasticloadbalancing:DescribeLoadBalancers",
            "elasticloadbalancing:DescribeTags",
            "elasticloadbalancing:DescribeTargetGroups",
            "elasticache:DescribeCacheClusters",
            "redshift:DescribeClusters",
            "lambda:GetAlias",
            "lambda:ListFunctions",
            "lambda:ListTags",
            "autoscaling:DescribeAutoScalingGroups",
            "s3:ListAllMyBuckets",
            "s3:ListBucket",
            "s3:GetBucketLocation",
            "s3:GetBucketTagging",
            "ecs:ListServices",
            "ecs:ListTasks",
            "ecs:DescribeTasks",
            "ecs:DescribeServices",
            "ecs:ListClusters",
            "ecs:DescribeClusters",
            "ecs:ListTaskDefinitions",
            "ecs:ListTagsForResource",
            "apigateway:GET",
            "cloudfront:ListDistributions",
            "cloudfront:ListTagsForResource",
            "tag:GetResources",
            "es:ListDomainNames",
            "es:DescribeElasticsearchDomain",
            "budgets:ViewBudget",
            "codedeploy:List*",
            "codedeploy:BatchGet*",
            "directconnect:Describe*",
            "elasticfilesystem:DescribeFileSystems",
            "elasticfilesystem:DescribeTags",
            "health:DescribeEvents",
            "health:DescribeEventDetails",
            "health:DescribeAffectedEntities",
            "route53:List*",
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
