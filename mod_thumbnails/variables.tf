variable "resource_grp_name" {
  type        = string
  description = "Give a name to the resource group e.g. friends-capstone-vpc"
}

variable "container_image" {
  type        = string
  description = "Full URI to the container image e.g. 255945442255.dkr.ecr.us-west-2.amazonaws.com/pydbcapstone:latest"
}

variable "container_name" {
  type        = string
  description = "Name of the container application e.g. pydbcapstone"
}

variable "service_app_port" {
  type        = number
  description = "The ports to be used for this service. The same port is used for the container internal application port, container host port, and the ALB port listening for connections to this service"
}

variable "region" {
  type        = string
  description = "Name of the region to host this container e.g. us-west-2"
}
