module "crud_api" {
  source = "../../mod_service"

  # Naming
  resource_grp_name = var.resource_grp_name
  proj_name         = var.proj_name

  # Container
  container_image  = var.container_image
  container_name   = var.container_name
  service_app_port = var.service_app_port

  # Service settings
  desired_count                      = 4
  min_count                          = 1
  max_count                          = 8
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50
  cpu_usage_scaling_trigger          = 60
  memory_usage_scaling_trigger       = 80


  # Load balancer settings
  load_balancer_arn     = data.aws_lb.ecs_alb.arn
  alb_security_group_id = data.aws_security_group.alb_security_group.id
  health_check_path     = "/api/healthcheck"

  # Networking
  vpc_id           = local.vpc_id_found
  ecs_cluster_id   = data.aws_ecs_cluster.ecs_cluster.id
  ecs_cluster_name = data.aws_ecs_cluster.ecs_cluster.cluster_name
  subnets          = data.aws_subnets.pvt_subnets.ids

  # IAM policies to attach to task
  ecs_task_policies_arn = var.ecs_task_policies_arn

}