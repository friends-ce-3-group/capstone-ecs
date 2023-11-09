resource "aws_security_group" "common" {
  name   = "${var.resource_grp_name}-sg"
  vpc_id = var.vpc_id

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress rules to be attached to security group with "aws_security_group_rule"
  # This has to include the port that the listener is listening to, for the particular service
  # ingress {
  # }

  tags = {
    name    = "${var.resource_grp_name}-sg",
    project = "${var.proj_name}"
  }
}


