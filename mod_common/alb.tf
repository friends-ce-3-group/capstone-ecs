resource "aws_lb" "common" {
  name               = "${var.resource_grp_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.common.id]
  subnets            = var.subnets # var.subnets_public

  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.alb_log.id
    enabled = true
  }

  tags = {
    name    = "${var.resource_grp_name}-alb",
    project = "${var.proj_name}"
  }

  depends_on = [
    aws_s3_bucket.alb_log,
    aws_s3_bucket_policy.allow_alb_logging
  ]
}

resource "aws_s3_bucket" "alb_log" {
  bucket = "${var.resource_grp_name}-alb-log"

  tags = {
    name      = "${var.resource_grp_name}-alb-log"
    proj_name = var.proj_name
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.alb_log.id
  versioning_configuration {
    status = "Enabled"
  }
}

locals {
  elb_account_id = "797873946194" # US West (Oregon). See https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html
}


# See https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html
data "aws_iam_policy_document" "allow_alb_logging" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.elb_account_id}:root"]
    }

    actions = ["s3:PutObject"]

    # See https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html
    resources = ["${aws_s3_bucket.alb_log.arn}/AWSLogs/#{AWSACCOUNTID}#/*"]
  }
}

resource "aws_s3_bucket_policy" "allow_alb_logging" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.allow_alb_logging.json
}