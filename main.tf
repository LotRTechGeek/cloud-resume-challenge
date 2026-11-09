resource "aws_s3_bucket" "cloud_resume" {
  bucket = var.bucket_name

  tags = {
    Project = "Cloud Resume Challenge"
    Owner   = "Andrew Timms"
  }
}

resource "aws_s3_bucket_website_configuration" "cloud_resume" {
  bucket = aws_s3_bucket.cloud_resume.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "cloud_resume" {
  bucket = aws_s3_bucket.cloud_resume.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "cloud_resume" {
  bucket = aws_s3_bucket.cloud_resume.id

  depends_on = [
    aws_s3_bucket_public_access_block.cloud_resume
  ]

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid       = "PublicRead"
        Effect    = "Allow"
        Principal = "*"

        Action = [
          "s3:GetObject"
        ]

        Resource = [
          "${aws_s3_bucket.cloud_resume.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.cloud_resume.id
  key          = "index.html"
  source       = "${path.module}/website/index.html"
  content_type = "text/html"

  etag = filemd5("${path.module}/website/index.html")
}

resource "aws_s3_object" "css" {
  bucket       = aws_s3_bucket.cloud_resume.id
  key          = "styles.css"
  source       = "${path.module}/website/styles.css"
  content_type = "text/css"

  etag = filemd5("${path.module}/website/styles.css")
}
resource "aws_cloudfront_distribution" "cloud_resume" {

  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket_website_configuration.cloud_resume.website_endpoint
    origin_id   = "s3-website"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"

      origin_ssl_protocols = [
        "TLSv1.2"
      ]
    }
  }

  default_cache_behavior {

    allowed_methods = [
      "GET",
      "HEAD"
    ]

    cached_methods = [
      "GET",
      "HEAD"
    ]

    target_origin_id = "s3-website"

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {

    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}