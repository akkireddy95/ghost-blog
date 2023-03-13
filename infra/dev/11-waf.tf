resource "aws_wafv2_web_acl" "waf" {
  name        = var.waf_name
  scope       = "REGIONAL"
  description = "Web ACL for ${var.website_name}"

  default_action {
    block {}
  }

  dynamic "rule" {
    for_each = var.waf_ip_sets
    content {
      name     = rule.value.name
      priority = rule.value.priority

      statement {
        ip_set_reference_statement {
          arn = aws_wafv2_ip_set.ip_set.arn
        }
      }

      action {
        block {}
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "WAF-${var.website_name}-${rule.value.name}-Block"
        sampled_requests_enabled   = true
      }
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "WAF-${var.website_name}-All-Rules"
    sampled_requests_enabled   = true
  }

  tags = {
    Name = var.waf_name
  }
}
