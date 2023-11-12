
data "aws_iam_policy_document" "eventbridge_invoke_ecs_task_policy_document" {
  statement {
    effect = "Allow"
    actions = ["ecs:RunTask"]
    resources = [aws_ecs_task_definition.thumbnails.arn]
    condition {
      test = "ArnLike"
      variable = "ecs:cluster"
      values = [ var.ecs_cluster_arn ]
    }
  }

  statement {
    effect = "Allow"
    actions = ["iam:PassRole"]
    resources = ["*"]
    condition {
      test = "StringLike"
      variable = "iam:PassedToService"
      values = [ "ecs-tasks.amazonaws.com" ]
    }
  }
}

resource "aws_iam_policy" "eventbridge_invoke_ecs_task_policy" {
  name        = "${var.proj_name}-thumbnails-eventBridge-ecsTask-iam_policy"
  description = "iam policy to allow eventbridge to access ecs_task"
  policy      = data.aws_iam_policy_document.eventbridge_invoke_ecs_task_policy_document.json
}

resource "aws_iam_role" "eventbridge_invoke_ecs_task_role" {
  name               = "${var.proj_name}-thumbnails-eventBridge-ecsTask-iam-role"
  assume_role_policy = <<EOF
{
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  EOF
}

resource "aws_iam_role_policy_attachment" "api_gateway_role_s3_policy_attachment" {
  policy_arn = aws_iam_policy.eventbridge_invoke_ecs_task_policy.arn
  role       = aws_iam_role.eventbridge_invoke_ecs_task_role.name
}