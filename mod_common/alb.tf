resource "aws_lb" "common" {
  name               = "${var.resource_grp_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.common.id]
  subnets            = var.subnets # var.subnets_public

  enable_deletion_protection = false

  tags = {
    name    = "${var.resource_grp_name}-alb",
    project = "${var.proj_name}"
  }
}
