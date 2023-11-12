variable "proj_name" {
  type    = string
  default = "friends-capstone"
}

variable "resource_grp_name" {
  type    = string
  default = "friends-capstone-thumbnails-api"
}

variable "image_bucket_name" {
  type    = string
  default = "friends-capstone-infra-s3-images"
}

variable "container_image" {
  type    = string
  default = "255945442255.dkr.ecr.us-west-2.amazonaws.com/pythumbnailscapstone:latest"
}

variable "container_name" {
  type    = string
  default = "pythumbnailscapstone"
}

variable "service_app_port" {
  type        = number
  default     = 80
  description = "This port number applies to the container internal port, container host port"
}

variable "region" {
  type        = string
  default     = "us-west-2"
  description = "us-west-2"
}
