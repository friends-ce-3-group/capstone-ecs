data "aws_vpcs" "vpc" {
  tags = {
    Name = "${var.proj_name_root}-*"
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
  vpc_id_found = element(data.aws_vpcs.vpc.ids, 0)
}
