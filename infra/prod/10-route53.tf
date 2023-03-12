resource "aws_route53_zone" "ghostblog" {
  name = var.r53_primary_zone
}

resource "aws_route53_record" "ghostblog_elb" {
  zone_id = aws_route53_zone.ghostblog.zone_id
  name    = "www.${var.r53_primary_zone}"
  type    = "A"
  ttl     = "300"
  alias {
    name                   = aws_lb.ghostblog.dns_name
    zone_id                = aws_lb.ghostblog.zone_id
    evaluate_target_health = true
  }
}
