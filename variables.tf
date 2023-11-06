variable "proj_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

# variable "vpc_cidr" {
#   type = string
# }

# variable "region" {
#   type = string
# }

# variable "enable_dns_hostnames" {
#   type = bool
# }

# variable "enable_dns_support" {
#   type = bool
# }

# variable "map_public_ip_on_launch" {
#   type = bool
# }

# variable "public_subnets" {
#   type = map(object({
#     cidr_block        = string
#     availability_zone = string
#   }))
# }

# variable "pvt_subnets" {
#   type = map(object({
#     cidr_block        = string
#     availability_zone = string
#   }))
# }

variable "container_host_port" {
  type = number
}

variable "container_name" {
  type = string
}

variable "container_image" {
  type = string
}

variable "health_check_path" {
  default = "/"
}

variable "alb_open_to_internet_port" {
  type = number
}

variable "subnets_private" {
  type = list(string)
}

variable "subnets_public" {
  type = list(string)
}