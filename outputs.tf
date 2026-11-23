output "bucket_name" {
  value = aws_s3_bucket.cloud_resume.bucket
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.cloud_resume.website_endpoint
}

output "website_url" {
  value = "http://${aws_s3_bucket_website_configuration.cloud_resume.website_endpoint}"
}

output "cloudfront_domain" {
  value = aws_cloudfront_distribution.cloud_resume.domain_name
}

output "cloudfront_url" {
  value = "https://${aws_cloudfront_distribution.cloud_resume.domain_name}"
}

output "visitor_counter_url" {
  value = "${aws_apigatewayv2_api.counter.api_endpoint}/count"
}
output "route53_zone_id" {
  description = "Route53 Hosted Zone ID"
  value       = aws_route53_zone.main.zone_id
}

output "route53_name_servers" {
  description = "Route53 Name Servers"
  value       = aws_route53_zone.main.name_servers
}