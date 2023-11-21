resource "aws_cloudwatch_log_group" "alb_access_log_group" {
  name              = "/alb/${var.resource_grp_name}-alb-access-log"
  retention_in_days = 0
}


resource "aws_iam_role" "lambda_forward_logs_s3_cloudwatch_role" {
  name = "${var.resource_grp_name}-lambda-forward-logs-role"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
  }
  EOF

  tags = {
    name      = "${var.resource_grp_name}-lambda-forward-logs-role"
    proj_name = var.proj_name
  }
}


resource "aws_iam_role_policy" "lambda_forward_logs_s3_cloudwatch_role_policy" {
  name   = "${var.resource_grp_name}-lambda-forward-logs-s3-cloudwatch-policy"
  role   = aws_iam_role.lambda_forward_logs_s3_cloudwatch_role.id
  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents",
          "logs:GetLogEvents",
          "logs:FilterLogEvents",
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ],
        "Resource": "*"
      },
      {
        "Action": [
          "s3:GetObject"
        ],
        "Effect": "Allow",
        "Resource": ["*"]
      }
    ]
  }
  EOF
}

data "archive_file" "archive_pipe_logs_s3_cloudwatch_lambda" {
  type        = "zip"
  source_file = "${path.module}/index.js"
  output_path = "${path.module}/archive.zip"
}

resource "aws_lambda_function" "forward_logs_s3_cloudwatch" {
  filename      = "${path.module}/archive.zip"
  function_name = "${var.resource_grp_name}-alb-forward-logs"
  role          = aws_iam_role.lambda_forward_logs_s3_cloudwatch_role.arn
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  timeout       = 30

  // Redeploy when lambda function code change
  source_code_hash = data.archive_file.archive_pipe_logs_s3_cloudwatch_lambda.output_base64sha256

  tracing_config {
    mode = "Active"
  }

  environment {
    variables = {
      environment  = "dev"
      logGroupName = aws_cloudwatch_log_group.alb_access_log_group.name
    }
  }

  // Optional can route through internet
  # vpc_config {
  #     subnet_ids = var.subnet_ids
  #     security_group_ids = var.security_group_ids
  # }
}

resource "aws_lambda_permission" "allow_bucket_forward_logs" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.forward_logs_s3_cloudwatch.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.alb_log.arn
}

resource "aws_s3_bucket_notification" "aws_lambda_trigger_alb_cloudfront" {
  depends_on = [aws_lambda_permission.allow_bucket_forward_logs]
  bucket     = aws_s3_bucket.alb_log.bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.forward_logs_s3_cloudwatch.arn
    events              = ["s3:ObjectCreated:*"] // When new object created in S3 it will trigger the lambda function
  }
}