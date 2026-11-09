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