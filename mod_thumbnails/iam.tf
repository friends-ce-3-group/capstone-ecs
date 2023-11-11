#data "aws_iam_policy_document" "eventbridge_ecs_run_task" {
#  statement {
#    actions = ["ecs:RunTask"]
#
#    effect = "Allow"
#    resources = [
#      aws_ecs_task_definition.thumbnails.arn
#    ]
#  }
#}