resource "aws_lb" "main" {
  name               = "${var.proj_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.subnets_public

  enable_deletion_protection = false
}

resource "aws_alb_target_group" "main" {
  name     = "${var.proj_name}-tg"
  port     = var.container_host_port # ALB directs traffic to this port on the target group hosts. make sure the container host port set in Task Definitions is the same port
  protocol = "HTTP"
  # vpc_id      = module.test_network.vpc_id
  vpc_id      = var.vpc_id
  target_type = "ip"

  tags = {
    Name = "${var.proj_name}-tg"
  }

  health_check {
    healthy_threshold   = "2"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.main.id
  port              = var.alb_open_to_internet_port # ALB listens on this port for incoming traffic from internet. make sure ALB security group allows this port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.main.id
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