# resource "aws_security_group_rule" "ingress_at_alb" {
#   type              = "ingress"
#   protocol          = "tcp"
#   from_port         = var.service_app_port
#   to_port           = var.service_app_port
#   security_group_id = var.alb_security_group_id
#   cidr_blocks       = ["0.0.0.0/0"]
# }

resource "aws_security_group" "ecs_tasks" {
  name   = "${var.resource_grp_name}-sg-ecstask"
  vpc_id = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = var.service_app_port # the host port in the container port mapping must be among the ports allowed in this range
    to_port         = var.service_app_port
    security_groups = [var.alb_security_group_id]
  }

  # allow CW Prometheus agent to scrape metrics from CRUD API service
  ingress {
    protocol        = "-1"
    from_port       = 0
    to_port         = 65535
    self            = true
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
