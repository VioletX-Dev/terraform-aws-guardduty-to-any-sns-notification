## AWS GuardDuty sending notifications to any SNS topic

This module enables AWS Guard Duty and send all Guard Duty findings message to any SNS TOpic you defined.

## Usage:

```
module "example" {
  source = "github.com/VioletX-Dev/terraform-aws-guardduty-to-any-sns-notification?ref=main"

  name                         = "guard-duty-findings-ACME"
  finding_publishing_frequency = "ONE_HOUR"
  alarm_notification_channel   = "arn:aws:sns:us-east-1:1234567890:my-sns-notification-channel"

}
```


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_guardduty_detector.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_detector) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_notification_channel"></a> [alarm\_notification\_channel](#input\_alarm\_notification\_channel) | It's a SNS ARN that might send emails, page your Incident Response tool (Pager Duty, OpsGenie, VitorOps, etc) | `string` | n/a | yes |
| <a name="input_finding_publishing_frequency"></a> [finding\_publishing\_frequency](#input\_finding\_publishing\_frequency) | Frequency with which to publish findings (must be one of `FIFTEEN_MINUTES`, `ONE_HOUR`, `SIX_HOURS`) | `string` | `"ONE_HOUR"` | no |
| <a name="input_name"></a> [name](#input\_name) | Project name to be used on SNS, GuardDuty, CloudWatch | `string` | `"guard-duty-findings"` | no |

## Outputs

No outputs.