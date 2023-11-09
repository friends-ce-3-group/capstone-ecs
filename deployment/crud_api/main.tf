module "crud_api" {
    source = "../../mod_service"

    # Naming
    resource_grp_name = var.resource_grp_name
    proj_name = var.proj_name

    # Container
    container_image = "255945442255.dkr.ecr.us-west-2.amazonaws.com/pydbcapstone:latest"
    container_name = "pydbcapstone"
    service_app_port = 5000

    # Service settings
    desired_count = 4
    deployment_maximum_percent = 200
    deployment_minimum_healthy_percent = 50

    # Load balancer settings
    load_balancer_arn = data.aws_lb.ecs_alb.arn
    alb_security_group_id = data.aws_security_group.alb_security_group.id
    health_check_path = "/api/healthcheck"
    
    # Networking
    vpc_id = local.vpc_id_found
    ecs_cluster_id = data.aws_ecs_cluster.ecs_cluster.id
    subnets = data.aws_subnets.pvt_subnets.ids

    # IAM policies to attach to task
    ecs_task_policies_arn = var.ecs_task_policies_arn

}