resource "aws_alb_target_group" "service" {
  name        = "${var.resource_grp_name}-tg"
  port        = var.service_app_port # Container host port. ALB directs traffic to this port on the target group hosts. make sure the container host port set in Task Definitions is the same port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "2"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
    port                = var.service_app_port
  }

  tags = {
    name    = "${var.resource_grp_name}-tg",
    project = "${var.proj_name}"
  }

}

resource "aws_alb_listener" "http" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.service_app_port # ALB listens on this port for incoming traffic from internet. make sure ALB security group allows this port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.service.id
  }

  tags = {
    name    = "${var.resource_grp_name}-tg",
    project = "${var.proj_name}"
  }
}

# resource "aws_alb_listener" "https" {
#   load_balancer_arn = aws_lb.main.id
#   port              = 443
#   protocol          = "HTTPS"

#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = var.alb_tls_cert_arn

#   default_action {
#     target_group_arn = aws_alb_target_group.main.id
#     type             = "forward"
#   }
# }