variable "proj_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

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