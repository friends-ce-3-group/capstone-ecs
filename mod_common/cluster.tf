resource "aws_ecs_cluster" "common" {
  name = "${var.proj_name}-cluster"

  tags = {
    name    = "${var.proj_name}-cluster",
    project = "${var.proj_name}"
  }

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
