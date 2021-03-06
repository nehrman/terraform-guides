# Optional extra resources to help encrypt your Slack Webhook URL

# This key is used to encrypt the slack webhook URL
resource "aws_kms_key" "notify_slack" {
    description = "Key for encrypting the Slack webhook URL"
    enable_key_rotation = "false"
    is_enabled = "true"
}

# A human friendly alias so we can find it in the UI
resource "aws_kms_alias" "notify_slack" {
  name          = "alias/notify_slack"
  target_key_id = "${aws_kms_key.notify_slack.key_id}"
}

# Template for our 'decrypt_kms' lambda IAM policy
data "template_file" "iam_decrypt_kms" {
  template = "${file("./files/iam_decrypt_kms.tpl")}"

  vars {
    kmskey = "${aws_kms_key.notify_slack.arn}"
    account_id = "${data.aws_caller_identity.current.account_id}"
    region = "${var.region}"
  }
}

# Here we ingest the template and attach it to our notify_slack role
resource "aws_iam_role_policy" "decrypt_kms" {
	name = "decrypt_kms"
	policy = "${data.template_file.iam_decrypt_kms.rendered}"
  role = "${aws_iam_role.lambda_notify.id}"
}