variable "region" {
  default     = "eu-central-1"
  description = "AWS Region"
}

# Set your Slack Webhook URL here.  For extra security you can use AWS KMS to 
# encrypt this data in the AWS console.
variable "slack_hook_url" {
  default = "https://hooks.slack.com/services/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"
  description = "Slack incoming webhook URL, get this from the slack management page."
}

variable "slack_channel" {
  default = "#terraform-demo"
  description = "Slack channel your bot will post messages to."
}

variable "mandatory_tags" {
  default = "TTL,owner"
  description = "Comma separated string mandatory tag values."
}

variable "sleep_days" {
  default = "99"
  description = "Days after launch after which untagged instances are stopped."
}

variable "reap_days" {
  default = "199"
  description = "Days after launch after which untagged instances are terminated."
}

variable "is_active" {
  default = "False"
  description = "Determines whether scripts will actually stop and terminate instances or do a dry run instead."
}
