# capstone-ecs

This repo contains the following modules:

| Module      | Description                                                                                                                                                          |
|-------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| mod_common  | A module for the common infrastructure used by a single ECS cluster, including the cluster itself, an application load balancer (ALB), and a security group for the ALB. |
| mod_service | A module for deploying a service within the ECS cluster. This module creates the ECS task definition, ECS service, target group (of the running tasks), security group for the running tasks, an ALB port listener to expose the service, and also the ECS IAM task execution and task roles and their attached policies.
| mod_thumbnails | A module for deploying an EventBridge rule that targets the an ECS Task within the ECS cluster. This module creates the EventBridge rule with S3 as the event, the ECS task definition and the required iam roles.
| mod_prometheus | A module for deploying a Prometheus server, running as an ECS service alongside the CRUD API service within the same cluster, to collect Prometheus metrics data.
