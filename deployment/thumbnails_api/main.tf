module "thumbnails_api" {
  source = "../../mod_thumbnails"

  # Naming
  proj_name                      = var.proj_name
  resource_grp_name              = var.resource_grp_name
  resource_s3_images_bucket_name = var.image_bucket_name

  # Container
  container_image  = var.container_image
  container_name   = var.container_name
  service_app_port = var.service_app_port

  # Service settings
  region = var.region

  # Networking
  ecs_cluster_arn             = data.aws_ecs_cluster.ecs_cluster.arn
  private_subnets             = data.aws_subnets.pvt_subnets.ids
  ecs_task_security_group_ids = data.aws_security_groups.ecs_task_security_group.id

  # IAM policies to attach to task
  # ecs_task_role               = data.ecs_task_role
  ecs_task_role_arn           = data.aws_iam_role.ecs_task_role.arn
  ecs_task_execution_role_arn = data.aws_iam_role.ecs_task_execution_role.arn



}