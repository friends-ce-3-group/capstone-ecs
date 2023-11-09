variable "resource_grp_name" {
  type        = string
  description = "Give a name to the resource group e.g. friends-capstone-vpc"
}

variable "proj_name" {
  type        = string
  description = "Give a name to the parent project of the resource group e.g. friends-capstone"
}

variable "service_app_port" {
    type        = number
    description = "The ports to be used for this service. The same port is used for the container internal application port, container host port, and the ALB port listening for connections to this service"
}

variable "health_check_path" {
    type = string
    description = "The http path to the health check service that returns 200 status code for healthy"
}

variable "load_balancer_arn" {
    type = string
    description = "ARN of the load balancer"
}

variable "container_image" {
    type = string
    description = "Full URI to the container image e.g. 255945442255.dkr.ecr.us-west-2.amazonaws.com/pydbcapstone:latest"
}

variable "container_name" {
    type = string
    description = "Name of the container application e.g. pydbcapstone"
}

variable "ecs_cluster_id" {
    type = string
    description = "ID of the ECS cluster"
}

variable "desired_count" {
    type = number
    description = "The target number of tasks that should be running"
}

variable "deployment_minimum_healthy_percent" {
    type = number
}

variable "deployment_maximum_percent" {
    type = number
}

variable "subnets" {
    type = list(string)
    description = "The subnets where the ECS target group will be running in"
}

variable "vpc_id" {
    type = string
}

variable "ecs_task_policies_arn" {
    type = list(string)
    description = "ARNs of all ECS task policies to attach to the service role. e.g. arn:aws:iam::aws:policy/AmazonRDSDataFullAccess"
}

variable "alb_security_group_id" {
    type = string
    description = "ID of the ALB security group. For attaching security group rules to the ALB, for opening up ports"
}