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