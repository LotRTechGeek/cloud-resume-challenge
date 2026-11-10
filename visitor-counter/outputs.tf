output "visitor_counter_url" {
  value = "${aws_apigatewayv2_api.counter.api_endpoint}/count"
}