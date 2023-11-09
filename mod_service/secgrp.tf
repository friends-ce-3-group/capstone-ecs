resource "aws_security_group_rule" "ingress_at_alb" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = var.service_app_port
  to_port           = var.service_app_port
  security_group_id = var.alb_security_group_id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "ecs_tasks" {
  name   = "${var.resource_grp_name}-sg-ecstask"
  vpc_id = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = var.service_app_port # the host port in the container port mapping must be among the ports allowed in this range
    to_port         = var.service_app_port
    security_groups = [var.alb_security_group_id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name    = "${var.resource_grp_name}-sg-ecstask",
    project = "${var.proj_name}"
  }
}

# resource "aws_security_group" "alb" {
#   name   = "${var.proj_name}-sg-alb"
#   vpc_id = var.vpc_id

#   ingress {
#     protocol    = "tcp"
#     from_port   = var.alb_open_to_internet_port # make sure that the ALB listener port is among the ports open to the internet
#     to_port     = var.alb_open_to_internet_port
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     protocol    = "-1"
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     name   = "${var.proj_name}-sg-alb",
#     subnet = "public"
#   }
# }

# resource "aws_security_group" "ecs_tasks" {
#   name   = "${var.proj_name}-sg-task"
#   vpc_id = var.vpc_id

#   ingress {
#     protocol        = "tcp"
#     from_port       = var.container_host_port # the host port in the container port mapping must be among the ports allowed in this range
#     to_port         = var.container_host_port
#     security_groups = [aws_security_group.alb.id]
#   }

#   egress {
#     protocol    = "-1"
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     name   = "${var.proj_name}-sg-task",
#     subnet = "private"
#   }
# }