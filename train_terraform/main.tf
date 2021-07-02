provider "aws" {
  region = "eu-west-1"
}

resource "aws_lambda_function" "my_lambda" {
  role = aws_iam_role.lambda_exec_role.arn
  handler = "lambda.handler"
  runtime = "python3.7"
  filename = "lambda.zip"
  function_name = "test_terra"
  source_code_hash = filebase64sha256("lambda.zip")
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec"
  path = "/"
  assume_role_policy = file("assume_role_policy.json")
}

resource "aws_dynamodb_table" "test_terra_db" {
  billing_mode = "PROVISIONED"
  hash_key = "hash"
  range_key = "range"
  name = "test_terra_db_name"
  read_capacity = 5
  write_capacity = 5
  attribute {
    name = "hash"
    type = "S"
  }
  attribute {
    name = "range"
    type = "N"
  }
}

resource "aws_iam_role_policy" "lambda_policy" {
  policy = file("policy.json")
  name = "lambda_policy"
  role = aws_iam_role.lambda_exec_role.id
}


