module "ecs_shared_infra" {
  source = "../../common"

  resource_grp_name = var.resource_grp_name

  proj_name = var.proj_name

  subnets = data.aws_subnets.pub_subnets.ids

  vpc_id = local.vpc_id_found
}