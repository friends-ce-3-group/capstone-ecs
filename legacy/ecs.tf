resource "aws_ecs_cluster" "main" {
  name = "${var.proj_name}-cluster"
}

resource "aws_ecs_task_definition" "main" {
  family                   = "${var.proj_name}-task-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 3072
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  skip_destroy             = true

  # task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions = <<DEFINITION
  [
    {
      "image": "${var.container_image}",
      "name": "${var.container_name}",
      "networkmode": "awsvpc",
      "memory": 512,
      "cpu": 256,
      "portMappings":[
        {
          "containerPort":${var.container_host_port},
          "hostPort":${var.container_host_port}
        }
      ]
    }
  ]
  DEFINITION
}

resource "aws_ecs_service" "main" {
  name                               = "${var.proj_name}-service"
  cluster                            = aws_ecs_cluster.main.id
  task_definition                    = aws_ecs_task_definition.main.arn
  desired_count                      = 4
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"
  force_new_deployment               = true # setting this to true allows container images to be updated when a new container with the same tag is pushed into ECR. applies rolling update.

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    security_groups = [aws_security_group.ecs_tasks.id]
    # subnets          = [for subnet in module.test_network.subnets_private : subnet.id]
    subnets          = var.subnets_private
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.main.arn
    container_port   = var.container_host_port
    container_name   = var.container_name
  }

  # lifecycle {
  #   ignore_changes = [task_definition, desired_count]
  # }
}