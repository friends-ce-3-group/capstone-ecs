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