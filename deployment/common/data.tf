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


data "aws_prefix_list" "cloudfront" {
  prefix_list_id = "pl-82a045eb"
}

output "cloudfront" {
  value = data.aws_prefix_list.cloudfront.cidr_blocks
}