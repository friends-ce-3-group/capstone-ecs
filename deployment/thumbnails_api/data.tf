data "aws_vpcs" "vpc" {
  tags = {
    Name = "${var.proj_name}-*"
  }
}

data "aws_subnets" "pvt_subnets" {

  filter {
    name   = "vpc-id"
    values = data.aws_vpcs.vpc.ids
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = [false]
  }

}

data "aws_ecs_cluster" "ecs_cluster" {
  cluster_name = "${var.proj_name}-cluster"

  tags = {
    project = "${var.proj_name}"
  }
}

data "aws_iam_role" "ecs_task_role" {
  name = "friends-capstone-ecsTaskRole"
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "friends-capstone-ecsTaskExecutionRole"
}

data "aws_security_groups" "ecs_task_security_group" {
  tags = {
    name    = "${var.proj_name}-crud-api-sg-ecstask",
    project = "${var.proj_name}"
  }
}