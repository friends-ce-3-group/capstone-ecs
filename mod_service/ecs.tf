resource "aws_ecs_task_definition" "service" {
  family                   = "${var.resource_grp_name}-ecs-task"
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
          "containerPort":${var.service_app_port},
          "hostPort":${var.service_app_port}
        }
      ]
    }
  ]
  DEFINITION
}

resource "aws_ecs_service" "service" {
  name                               = "${var.resource_grp_name}-service"
  cluster                            = var.ecs_cluster_id
  task_definition                    = aws_ecs_task_definition.service.arn
  desired_count                      = var.desired_count
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent 
  deployment_maximum_percent         = var.deployment_maximum_percent         
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"
  force_new_deployment               = true # setting this to true allows container images to be updated when a new container with the same tag is pushed into ECR. applies rolling update.

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id] 
    subnets          = var.subnets                       
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.service.arn
    container_port   = var.service_app_port # container host port
    container_name   = var.container_name
  }

  # lifecycle {
  #   ignore_changes = [task_definition, desired_count]
  # }
}