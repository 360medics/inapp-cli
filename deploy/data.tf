# Private subnet
data "aws_subnet" "private-main" {
  filter {
    name   = "tag:Name"
    values = ["private-main"]
  }
}

# NLB
data "aws_lb" "nlb-main" {
  name = "nlb-main-tasks"
}

# VPC
data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["main"]
  }
}

# ECS cluster
data "aws_ecs_cluster" "main" {
  cluster_name = "tasks-main"
}

# Cloudwatch log group
data "aws_cloudwatch_log_group" "main" {
  name = "inapps-main"
}

# REST API
data "aws_api_gateway_rest_api" "main" {
  name = "inapps-main"
}

# VPC Link
data "aws_api_gateway_vpc_link" "main" {
  name = "inapps-main"
}

# ECR
data "aws_ecr_repository" "main" {
  name = "inapps-back"
}
