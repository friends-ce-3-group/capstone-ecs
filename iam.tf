data "aws_iam_policy_document" "ecs_task_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${var.proj_name}-ecsTaskRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}


data "aws_iam_policy_document" "rds" {
    statement {
    actions   = [
            "rds:*"
        ]
    resources = [ "arn:aws:rds:*:*:*:*" ]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "rds" {
    name = "${var.proj_name}-policy-rds"
    policy = data.aws_iam_policy_document.rds.json
}

resource "aws_iam_role_policy_attachment" "attach_rds_data_policy" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSDataFullAccess"
}


resource "aws_iam_role_policy_attachment" "attach_rds_ops_policy" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.rds.arn
}




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

# # --------------------------------------------------------------------------