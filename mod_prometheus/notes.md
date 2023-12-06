task_definition_list is an optional section that you can use to specify the configuration of task definition-based service discovery. If you omit this section, task definition-based discovery is not used. This section can contain the following fields:

- sd_task_definition_arn_pattern is the pattern to use to specify the Amazon ECS task definitions to discover. This is a regular expression.

- sd_metrics_ports lists the containerPort for the Prometheus metrics. Separate the containerPorts with semicolons.

- sd_container_name_pattern specifies the Amazon ECS task container names. This is a regular expression.

- sd_metrics_path specifies the Prometheus metric path. If you omit this, the agent assumes the default path /metrics

- sd_job_name specifies the Prometheus scrape job name. If you omit this field, the CloudWatch agent uses the job name in the Prometheus scrape configuration.

