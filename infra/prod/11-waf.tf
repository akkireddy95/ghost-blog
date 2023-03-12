# Create a Web ACL with IP match conditions and associated rules
resource "aws_wafv2_web_acl" "waf" {
  name        = var.waf_name
  scope       = "REGIONAL"
  description = "Web ACL for ${var.website_name}"

  default_action {
    block {}
  }

  # Define an IP match condition for the IP set
  dynamic "ip_set" {
    for_each = var.waf_ip_sets
    content {
      name     = ip_set.key
      priority = ip_set.value.priority

      ip_address_sets = [
        ip_set.value.ip_set_id
      ]
    }
  }

  # Create a rule to block any request from IPs in the IP match condition
  dynamic "rule" {
    for_each = var.waf_ip_sets
    content {
      name     = rule.key
      priority = rule.value.priority

      statement {
        ip_set_reference_statement {
          arn = aws_wafv2_ip_set.ip_set[rule.key].arn
        }
      }

      action {
        block {}
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                 = "WAF-${var.website_name}-${rule.key}-Block"
        sampled_requests_enabled    = true
      }
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                 = "WAF-${var.website_name}-All-Rules"
    sampled_requests_enabled    = true
  }

  tags = {
    Name = var.waf_name
  }
}

# Create an IP set
resource "aws_wafv2_ip_set" "ip_set" {
  for_each = var.waf_ip_sets

  name        = ip_set.value.name
  scope       = "REGIONAL"
  description = "IP set for ${ip_set.value.name}"

  ip_address_version = "IPV4"

  dynamic "ip_address" {
    for_each = ip_set.value.ip_addresses
    content {
      value = ip_address.value
    }
  }

  tags = {
    Name = ip_set.value.name
  }
}
