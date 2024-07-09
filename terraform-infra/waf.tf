resource "aws_wafv2_ip_set" "block_ip_set" {
  name               = "${local.env}-block-ip-set"
  scope              = "REGIONAL" # Use REGIONAL for ALBs
  ip_address_version = "IPV4"
  addresses = [
    "106.214.95.140/32"
  ]

  description = "IP Set for blocking specific IP addresses"
}
resource "aws_wafv2_web_acl" "main_acl" {
  name        = "${local.env}-web-acl"
  scope       = "REGIONAL"
  description = "Web ACL with IP blocking rules for the ALB"

  default_action {
    allow {} # Default action is to allow requests
  }

  rule {
    name     = "BlockSpecificIPs"
    priority = 1
    action {
      block {}
    }
    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.block_ip_set.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "BlockSpecificIPs"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${local.env}-web-acl"
    sampled_requests_enabled   = true
  }

  tags = {
    Name = "${local.env}-WebACL"
  }
}

