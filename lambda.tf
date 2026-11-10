resource "aws_lambda_function" "visitor_counter" {

  function_name = "resume-visitor-counter"

  filename = "visitor-counter/lambda.zip"

  source_code_hash = filebase64sha256(
  "visitor-counter/lambda.zip"
)

  

  handler = "lambda_function.lambda_handler"

  runtime = "python3.13"

  role = aws_iam_role.lambda_role.arn

  environment {

    variables = {
      TABLE_NAME = aws_dynamodb_table.visitor_counter.name
    }
  }
}