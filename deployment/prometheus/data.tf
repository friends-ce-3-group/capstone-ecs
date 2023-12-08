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

data "aws_ecs_cluster" "ecs_cluster" {
    cluster_name = "${var.proj_name}-cluster"
}

data "aws_security_group" "ecs_secgrp" {
  name = "${var.proj_name}-crud-*"
}

output "ecs_cluster" {
  value = data.aws_ecs_cluster.ecs_cluster.cluster_name
}


output "ecs_secgrp" {
  value = data.aws_security_group.ecs_secgrp.id
}

output "ecs_subnet_pvt" {
  value = data.aws_subnets.pvt_subnets.ids
}