variable "resource_grp_name" {
  type        = string
  description = "Give a name to the resource group e.g. friends-capstone-vpc"
}

variable "proj_name" {
  type        = string
  description = "Give a name to the parent project of the resource group e.g. friends-capstone"
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

variable "resource_s3_images_bucket_name" {
  type        = string
  description = "Name of the s3 bucket which contains our images e.g. friends-capstone-infra-s3-images"
}

variable "ecs_cluster_arn" {
  type        = string
  description = "arn of the ECS cluster"
}

#variable "ecs_task_role" {
#  type        = string
#  description = "task role of the ecs task"
#}

variable "private_subnets" {
  type        = list(string)
  description = "private subnets to run ecs tasks within"
}

variable "ecs_task_role_arn" {
  type        = string
  description = "task role arn for ecs tasks to use"
}

variable "ecs_task_execution_role_arn" {
  type        = string
  description = "execution role arn for ecs tasks to use"
}

variable "ecs_task_security_group_ids" {
  type        = list(string)
  description = "ID of the ecs task security group. For attaching security group rules."
}
