# data "aws_iam_policy_document" "ecs_task_assume_role" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["ecs-tasks.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role" "ecs_task_role" {
#   name = "${var.proj_name}-ecsTaskRole"
#   assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
# }


# data "aws_iam_policy_document" "dynamodb" {
#     statement {
#     actions   = [
#             "dynamodb:CreateTable",
#             "dynamodb:UpdateTimeToLive",
#             "dynamodb:PutItem",
#             "dynamodb:DescribeTable",
#             "dynamodb:ListTables",
#             "dynamodb:DeleteItem",
#             "dynamodb:GetItem",
#             "dynamodb:Scan",
#             "dynamodb:Query",
#             "dynamodb:UpdateItem",
#             "dynamodb:UpdateTable"
#         ]
#     resources = [ "arn:aws:dynamodb:*:*:*" ]
#     effect    = "Allow"
#   }
# }

# resource "aws_iam_policy" "dynamodb" {
#     name = "${var.proj_name}-policy-dynamodb"
#     policy = data.aws_iam_policy_document.dynamodb.json
# }

# resource "aws_iam_role_policy_attachment" "attach_dynamodb" {
#   role       = aws_iam_role.ecs_task_role.name
#   policy_arn = aws_iam_policy.dynamodb.arn
# }


# # --------------------------------------------------------------------------
# # --------------------------------------------------------------------------
# # --------------------------------------------------------------------------
# # --------------------------------------------------------------------------

data "aws_iam_policy_document" "ecs_task_exec_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.proj_name}-ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_exec_assume_role.json
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}