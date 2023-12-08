data "template_file" "cloudfmn_template" {
  template = file("${path.module}/../../mod_prometheus/prometheus-install.sh.in")
  vars = {
    ECS_CLUSTER_NAME = data.aws_ecs_cluster.ecs_cluster.cluster_name
    ECS_CLUSTER_SECURITY_GROUP = data.aws_security_group.ecs_secgrp.id
    ECS_CLUSTER_SUBNET = element(data.aws_subnets.pvt_subnets.ids, 0)
    ECS_LAUNCH_TYPE = "FARGATE"
    AWS_DEFAULT_REGION = "us-west-2"
    CREATE_IAM_ROLES = "True"
  }
}

resource "local_file" "cloudfmn_exec" {
  content  = data.template_file.cloudfmn_template.rendered
  filename = "${path.module}/prometheus-install.sh"
}