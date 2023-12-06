#!/bin/bash
export AWS_DEFAULT_REGION=us-west-2
export ECS_CLUSTER_NAME=friends-capstone-cluster
export ECS_CLUSTER_SECURITY_GROUP=sg-0be3f39c43f516f24
export ECS_CLUSTER_SUBNET=subnet-08770f0364536c234
export ECS_LAUNCH_TYPE=FARGATE
export CREATE_IAM_ROLES=True


aws cloudformation deploy --stack-name CWAgent-Prometheus-ECS-${ECS_CLUSTER_NAME}-${ECS_LAUNCH_TYPE}-awsvpc \
    --template-file install-prometheus-collector.yml \
    --parameter-overrides ECSClusterName=${ECS_CLUSTER_NAME} \
                CreateIAMRoles=${CREATE_IAM_ROLES} \
                ECSLaunchType=${ECS_LAUNCH_TYPE} \
                SecurityGroupID=${ECS_CLUSTER_SECURITY_GROUP} \
                SubnetID=${ECS_CLUSTER_SUBNET} \
                TaskRoleName=Prometheus-TaskRole-${ECS_CLUSTER_NAME} \
                ExecutionRoleName=Prometheus-ExecutionRole-${ECS_CLUSTER_NAME} \
    --capabilities CAPABILITY_NAMED_IAM \
    --region ${AWS_DEFAULT_REGION} 