variable "proj_name" {
  type    = string
  default = "friends-capstone"
}

variable "resource_grp_name" {
  type    = string
  default = "friends-capstone-ecs-shared"
}

variable "service_app_port" {
  type        = number
  default     = 5000
  description = "This port number applies to the container internal port, container host port, security groups connection between the ALB and ECS task, and ALB listening port for the service"
}