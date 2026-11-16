resource "aws_route53_zone" "main" {
  name = "andylotrtechie.uk"

  tags = {
    Project = "Cloud Resume Challenge"
    Owner   = "Andrew Timms"
  }
}
resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "andylotrtechie.uk"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloud_resume.domain_name
    zone_id                = aws_cloudfront_distribution.cloud_resume.hosted_zone_id
    evaluate_target_health = false
  }
}
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.andylotrtechie.uk"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloud_resume.domain_name
    zone_id                = aws_cloudfront_distribution.cloud_resume.hosted_zone_id
    evaluate_target_health = false
  }
}
resource "aws_route53_record" "acm_validation" {
  zone_id = aws_route53_zone.main.zone_id

  name = "_b245d0f26a4d5850b12c0ba8a381fb51.andylotrtechie.uk"
  type = "CNAME"
  ttl  = 300

  records = [
    "_e243c4f2706e324ea5061618f3d9e91b.wzccmgtwzk.acm-validations.aws"
  ]
}