variable "resource_grp_name" {
  type        = string
  description = "Give a name to the resource group e.g. friends-capstone-vpc"
}

variable "proj_name" {
  type        = string
  description = "Give a name to the parent project of the resource group e.g. friends-capstone"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnets that the ALB has to direct traffic to"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID of the VPC that the ALB belongs to"
}

variable "service_app_port" {
  type        = number
  default     = 5000
  description = "This port number applies to the container internal port, container host port, security groups connection between the ALB and ECS task, and ALB listening port for the service"
}

variable "cloudfront_cidr_blocks" {
  type        = list(string)
  description = "Cidr ranges for Cloudfront in the region"
}