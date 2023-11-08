variable "proj_name" {
  type = string
}

variable "proj_name_root" {
  type = string
}

# variable "vpc_cidr" {
#   type = string
# }

variable "region" {
  type = string
}

# variable "enable_dns_hostnames" {
#   type = bool
# }

# variable "enable_dns_support" {
#   type = bool
# }

# variable "map_public_ip_on_launch" {
#   type = bool
# }

# variable "subnets_public" {
#   type = map(object({
#     cidr_block        = string
#     availability_zone = string
#   }))
# }

# variable "subnets_private" {
#   type = map(object({
#     cidr_block        = string
#     availability_zone = string
#   }))
# }

variable "container_host_port" {
  type        = number
  description = "the port on host machines that is mapped to the container port i.e. -p <container_host_port>:<container_app_port>"
}

variable "container_name" {
  type = string
}

variable "container_image" {
  type = string
  default = "255945442255.dkr.ecr.us-west-2.amazonaws.com/pydbcapstone:latest"
}

variable "health_check_path" {
  default = "/"
}

variable "alb_open_to_internet_port" {
  type        = number
  description = "the port that the ALB is listening on"
}
