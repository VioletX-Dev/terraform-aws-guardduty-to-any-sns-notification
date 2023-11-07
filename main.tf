##------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Enable AWS Guard Duty on AWS account
##------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
resource "aws_guardduty_detector" "this" {
  enable                       = true
  finding_publishing_frequency = var.finding_publishing_frequency
  datasources {
    s3_logs {
      enable = true
    }
    kubernetes {
      audit_logs {
        enable = false
      }
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          enable = true
        }
      }
    }
  }
  tags = {
    developed = "VioletX.com"
    terraform = "true"
  }
}

##------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## CloudWatch event rule for trigger SNS notification
##------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_event_rule" "this" {
  name        = var.name
  description = "Event rule for trigger SNS topic from AWS Guard duty"
  event_pattern = jsonencode(
    {
      "source" : ["aws.guardduty"],
      "detail-type" : ["GuardDuty Finding"]
    }
  )
  tags = {
    developed = "VioletX.com"
    terraform = "true"
  }
}

resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = "SendToSNS"
  arn       = var.alarm_notification_channel
  input_transformer {
    input_paths = {
      severity            = "$.detail.severity",
      Finding_ID          = "$.detail.id",
      Finding_Type        = "$.detail.type",
      region              = "$.region",
      Finding_description = "$.detail.description"
    }
    input_template = "\"You have a severity <severity> GuardDuty finding type <Finding_Type> in the <region> region.\"\n \"Finding Description:\" \"<Finding_description>. \"\n \"For more details open the GuardDuty console at https://console.aws.amazon.com/guardduty/home?region=<region>#/findings?search=id%3D<Finding_ID>\""
  }
}
