data "aws_iam_policy_document" "sfx_policy_doc" {
	statement {
		actions = ["sts:AssumeRole"]

		principals {
			type = "AWS"
			identifiers = [signalfx_aws_external_integration.sfx_integration_external.signalfx_aws_account]
		}

		condition {
			test = "StringEquals"
			variable = "sts:ExternalId"
			values = [signalfx_aws_external_integration.sfx_integration_external.external_id]
		}
	}
}

resource "aws_iam_role" "sfx_role" {
	name = "SignalFxAWSIntegrationRole-${random_id.suffix.b64_url}"
	description = "signalfx integration to read out data and send it to signalfxs aws account"
	assume_role_policy = data.aws_iam_policy_document.sfx_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "sfx_policy_attach" {
	role = aws_iam_role.sfx_role.name
	policy_arn = aws_iam_policy.sfx_policy.arn
}
