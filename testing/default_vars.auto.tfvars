proj_name = "friends-capstone-ecs"

vpc_cidr = "30.0.0.0/16"

region = "us-west-2"

enable_dns_hostnames = true

enable_dns_support = true

map_public_ip_on_launch = true

subnets_public = {
  us_west_2a_pub_subnet = {
    cidr_block        = "30.0.1.0/24"
    availability_zone = "us-west-2a"
  },
  us_west_2b_pub_subnet = {
    cidr_block        = "30.0.2.0/24"
    availability_zone = "us-west-2b"
  }
}

subnets_private = {
  us_west_2a_pvt_subnet = {
    cidr_block        = "30.0.3.0/24"
    availability_zone = "us-west-2a"
  }
  us_west_2b_pvt_subnet = {
    cidr_block        = "30.0.4.0/24"
    availability_zone = "us-west-2b"
  }
}

container_host_port = 5000

alb_open_to_internet_port = 80

container_name = "pydbcapstone"

container_image = "255945442255.dkr.ecr.us-west-2.amazonaws.com/pydbcapstone:latest"
