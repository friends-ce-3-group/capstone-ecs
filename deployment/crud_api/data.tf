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

data "aws_subnets" "pub_subnets" {

  filter {
    name   = "vpc-id"
    values = data.aws_vpcs.vpc.ids
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = [true]
  }

}

locals {
  vpc_id_found = element(data.aws_vpcs.vpc.ids, 0) # this has been filtered such that there is only one entry found. so take the single entry in the list.
}

data "aws_lb" "ecs_alb" {
  tags = {
    project = "${var.proj_name}"
  }
}

data "aws_ecs_cluster" "ecs_cluster" {
  cluster_name = "${var.proj_name}-cluster"

  tags = {
    project = "${var.proj_name}"
  }
}

data "aws_security_group" "alb_security_group" {
  tags = {
    name = "${var.proj_name}-ecs-shared-sg",
    project = "${var.proj_name}"
  }
}

