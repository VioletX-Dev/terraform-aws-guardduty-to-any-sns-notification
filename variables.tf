variable "finding_publishing_frequency" {
  default     = "ONE_HOUR"
  description = "Frequency with which to publish findings (must be one of `FIFTEEN_MINUTES`, `ONE_HOUR`, `SIX_HOURS`)"
  type        = string
}

variable "name" {
  default     = "guard-duty-findings"
  description = "Project name to be used on SNS, GuardDuty, CloudWatch"
  type        = string
}

variable "alarm_notification_channel" {
  description = "It's a SNS ARN that might send emails, page your Incident Response tool (Pager Duty, OpsGenie, VitorOps, etc)"
  type        = string
}

variable "has_kubernetes" {
  description = "If you have Kubernetes cluster set `true`."
  type = bool
  default = false
}
