resource "aws_ecs_task_definition" "thumbnails" {
  family                   = "${var.resource_grp_name}-ecs-task"
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 3072
  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
  container_definitions = <<DEFINITION
  [
    {
      "image": "${var.container_image}",
      "name": "${var.container_name}",
      "networkmode": "awsvpc",
      "cpu": 0,
      "portMappings":[
        {
          "containerPort":${var.service_app_port},
          "hostPort":${var.service_app_port}
        }
      ],
      "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
              "awslogs-create-group": "true",
              "awslogs-group": "/ecs/${var.resource_grp_name}-ecs-task",
              "awslogs-region": "${var.region}",
              "awslogs-stream-prefix": "ecs"
          },
          "secretOptions": []
      }
    }
  ]
  DEFINITION
}