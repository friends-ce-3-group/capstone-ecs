variable "proj_name" {
  type    = string
  default = "friends-capstone"
}

variable "resource_grp_name" {
  type    = string
  default = "friends-capstone-crud-api"
}

variable "ecs_task_policies_arn" {
  type = list(string)
  default = [ 
    "arn:aws:iam::aws:policy/AmazonRDSDataFullAccess",
    "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  ]
}

variable "container_image" {
  type = string
  default = "255945442255.dkr.ecr.us-west-2.amazonaws.com/pydbcapstone:latest"
}

variable "container_name" {
  type = string
  default = "pydbcapstone"
}

variable "service_app_port" {
  type = number
  default = 5000
  description = "This port number applies to the container internal port, container host port, security groups connection between the ALB and ECS task, and ALB listening port for the service"
}