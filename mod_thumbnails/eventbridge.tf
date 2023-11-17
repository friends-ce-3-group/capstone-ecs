resource "aws_cloudwatch_event_rule" "invoke_thumbnails_creation" {
  name = "${var.resource_grp_name}-event-rule"

  event_pattern = jsonencode(({
    source : ["aws.s3"],
    detail-type : ["Object Created"],
    detail : {
      bucket : {
        name : ["${var.resource_s3_images_bucket_name}"]
      },
      object : {
        key : [{ "prefix" : "originals/" }]
      }
    }
  }))
}

resource "aws_cloudwatch_event_target" "event_target" {
  arn      = var.ecs_cluster_arn
  rule     = aws_cloudwatch_event_rule.invoke_thumbnails_creation.name
  role_arn = aws_iam_role.eventbridge_invoke_ecs_task_role.arn

  ecs_target {
    launch_type             = "FARGATE"
    task_count              = 1
    task_definition_arn     = aws_ecs_task_definition.thumbnails.arn
    enable_ecs_managed_tags = true
    network_configuration {
      subnets          = var.private_subnets
      assign_public_ip = true
    }
  }

  input_transformer {
    input_paths = {
      "s3_bucket" : "$.detail.bucket.name",
      "s3_key" : "$.detail.object.key"
    }
    input_template = <<TEMPLATE
{
  "containerOverrides": [
    {
      "name": "pythumbnailscapstone",
      "environment": [
        { "name": "S3_BUCKET", "value": <s3_bucket> },
        { "name": "S3_KEY", "value": <s3_key> }
      ]
    }
  ]
}
    TEMPLATE
  }

}