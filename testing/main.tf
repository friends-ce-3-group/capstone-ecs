# module "vpc_network" {
#   source = "git::https://github.com/friends-ce-3-group/terraform-aws-network.git?ref=v0.1.5"

#   vpc_cidr = var.vpc_cidr

#   enable_dns_hostnames = var.enable_dns_hostnames

#   enable_dns_support = var.enable_dns_support

#   vpc_tags = {
#     Name = "${var.proj_name}-vpc"
#   }

#   map_public_ip_on_launch = var.map_public_ip_on_launch

#   public_subnets = var.subnets_public

#   tags_public_subnet = {
#     Name = "${var.proj_name}-public-SN"
#   }

#   private_subnets = var.subnets_private

#   tags_private_subnet = {
#     Name = "${var.proj_name}-pvt-SN"
#   }
# }



# module "ecs_services" {
#   source = "../"

#   proj_name = var.proj_name

#   container_image = var.container_image

#   container_name = var.container_name

#   container_host_port = var.container_host_port

#   alb_open_to_internet_port = var.alb_open_to_internet_port

#   vpc_id = module.vpc_network.vpc_id

#   subnets_private = [for subnet in module.vpc_network.subnets_private : subnet.id]

#   subnets_public = [for subnet in module.vpc_network.subnets_public : subnet.id]

#   depends_on = [module.vpc_network]
# }