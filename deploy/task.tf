resource "aws_ecs_service" "task" {
  # we're in private subnet
  network_configuration {
    subnets         = [data.aws_subnet.private-main.id]
    security_groups = [aws_security_group.ecs_task.id]
  }

  # say to nlb that we're the target group
  # we can register multiple load balancers but read this first
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/register-multiple-targetgroups.html
  load_balancer {
    target_group_arn = aws_lb_target_group.main.id
    # should be the exact same as the container name in task definition
    container_name = "${var.project}-${var.env}"
    # should be the exact same as the container port in task definition
    container_port = 4000
  }

  # wait for nlb to be ready
  depends_on = [aws_lb_listener.tcp]

  name    = "${var.project}-${var.env}"
  cluster = data.aws_ecs_cluster.main.arn
  # 1 service instance
  desired_count = 1

  launch_type = "FARGATE"

  # rollback to last stable version if deployment failed
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  task_definition = aws_ecs_task_definition.task.arn
}

resource "aws_ecs_task_definition" "task" {
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.inapp-execution-role.arn
  container_definitions = jsonencode([
    {
      name  = "${var.project}-${var.env}"
      image = "${data.aws_ecr_repository.main.repository_url}:${var.project}"
      // makes other containers within this task to be stopped
      // if this one fail for some reasons
      essential = true,
      environment = [
        {
          name  = "NODE_ENV",
          value = "${var.env}",
        },
        {
          name  = "API_PORT",
          value = "4000",
        },
        {
          name  = "PROJECT_NAME",
          value = "${var.project}",
        },
        {
          name  = "DATABASE_URL",
          value = "postgresql://${var.project}:${random_password.db_password.result}@${data.aws_db_instance.main.address}:${data.aws_db_instance.main.port}/${postgresql_database.task-db.name}?schema=public",
        },
      ],
      portMappings = [
        {
          protocol      = "tcp"
          containerPort = 4000
          hostPort      = 4000
        }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = data.aws_cloudwatch_log_group.main.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "${var.project}-${var.env}"
        }
      }
    }
  ])
  family = "${var.project}-${var.env}"

  # Help table
  # 256 (.25 vCPU)	512 (0.5GB), 1024 (1GB), 2048 (2GB)
  # 512 (.5 vCPU)	1024 (1GB), 2048 (2GB), 3072 (3GB), 4096 (4GB)
  # 1024 (1 vCPU)	2048 (2GB), 3072 (3GB), 4096 (4GB), 5120 (5GB), 6144 (6GB), 7168 (7GB), 8192 (8GB)
  # 2048 (2 vCPU)	Between 4096 (4GB) and 16384 (16GB) in increments of 1024 (1GB)
  # 4096 (4 vCPU)	Between 8192 (8GB) and 30720 (30GB) in increments of 1024 (1GB)

  # 0.25 vCPU
  cpu = 256
  # 512mb
  memory = 512

  network_mode = "awsvpc"

  tags = {
    "Name" = "${var.project}-${var.env}"
  }
}

// -------------------------------------
//          GENERATE PASSWORD
// -------------------------------------
resource "random_password" "db_password" {
  provider         = random
  length           = 16
  special          = true
  override_special = "_%@"
}

# and store it to circleci
resource "circleci_context_environment_variable" "db_password" {
  provider   = circleci
  variable   = "DB_PASSWORD"
  value      = random_password.db_password.result
  context_id = circleci_context.task.id
}

// -------------------------------------
//                  DB
// -------------------------------------
resource "postgresql_role" "task-role" {
  provider = postgresql.tunnel
  name     = var.project
  login    = true
  password = random_password.db_password.result
  depends_on = [
    module.db_tunnel
  ]
}

resource "postgresql_database" "task-db" {
  provider          = postgresql.tunnel
  name              = var.project
  owner             = postgresql_role.task-role.name
  template          = "template0"
  lc_collate        = "C"
  connection_limit  = -1
  allow_connections = true
}

// -------------------------------------
//                 ROLE
// -------------------------------------
resource "aws_iam_role" "inapp-execution-role" {
  name               = "${var.project}-${var.env}-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_policy" "logs_and_ecr_read" {
  name = "logs_and_ecr_read"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Action" : [
        "ecr:GetRegistryPolicy",
        "ecr:DescribeImageScanFindings",
        "ecr:GetLifecyclePolicyPreview",
        "ecr:GetDownloadUrlForLayer",
        "ecr:DescribeRegistry",
        "ecr:DescribeImageReplicationStatus",
        "ecr:GetAuthorizationToken",
        "ecr:ListTagsForResource",
        "ecr:BatchGetRepositoryScanningConfiguration",
        "logs:CreateLogGroup",
        "logs:PutLogEvents",
        "logs:CreateLogStream",
        "ecr:GetRegistryScanningConfiguration",
        "ecr:BatchGetImage",
        "ecr:DescribeRepositories",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetRepositoryPolicy",
        "ecr:GetLifecyclePolicy"
      ],
      "Resource" : "*"
    }]
  })
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_logs_attachment" {
  role       = aws_iam_role.inapp-execution-role.name
  policy_arn = aws_iam_policy.logs_and_ecr_read.arn
}

// -------------------------------------
//               NETWORK
// -------------------------------------
resource "aws_security_group" "ecs_task" {
  name   = "ecs_task"
  vpc_id = data.aws_vpc.main.id

  ingress {
    from_port = 4000
    to_port   = 4000
    protocol  = "tcp"
    // @TODO: only authroize NLB ip
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


# adds a tcp listener on nlb
resource "aws_lb_listener" "tcp" {
  load_balancer_arn = data.aws_lb.nlb-main.id
  # must be above 1024
  port     = var.nlb_listener_port
  protocol = "TCP"

  # by default, forward to the target group
  default_action {
    target_group_arn = aws_lb_target_group.main.id
    type             = "forward"
  }
}

resource "aws_lb_target_group" "main" {
  name        = "${var.project}-${var.env}"
  port        = 4000
  protocol    = "TCP"
  vpc_id      = data.aws_vpc.main.id
  target_type = "ip"

  # amount time for NLB to wait before changing the state of a deregistering target from draining to unused
  deregistration_delay = "30"

  health_check {
    protocol            = "HTTP"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# -------------------------------------
#              ROUTING
# -------------------------------------
resource "aws_api_gateway_resource" "task-root" {
  rest_api_id = data.aws_api_gateway_rest_api.main.id
  parent_id   = data.aws_api_gateway_rest_api.main.root_resource_id

  path_part = var.project
}

resource "aws_api_gateway_resource" "task" {
  rest_api_id = data.aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.task-root.id

  path_part = "{proxy+}"
}

resource "aws_api_gateway_method" "task" {
  rest_api_id      = aws_api_gateway_resource.task.rest_api_id
  resource_id      = aws_api_gateway_resource.task.id
  http_method      = "ANY"
  authorization    = "NONE"
  api_key_required = false
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "task" {
  rest_api_id = aws_api_gateway_method.task.rest_api_id
  resource_id = aws_api_gateway_method.task.resource_id
  http_method = aws_api_gateway_method.task.http_method

  type                    = "HTTP_PROXY"
  integration_http_method = "ANY"
  # must be above 1024
  uri             = "http://${data.aws_lb.nlb-main.dns_name}:${var.nlb_listener_port}/{proxy}"
  connection_type = "VPC_LINK"
  connection_id   = data.aws_api_gateway_vpc_link.main.id
  # 50-29000
  timeout_milliseconds = 29000

  cache_key_parameters = ["method.request.path.proxy"]
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}

resource "aws_api_gateway_method_response" "task" {
  rest_api_id = aws_api_gateway_integration.task.rest_api_id
  resource_id = aws_api_gateway_integration.task.resource_id
  http_method = aws_api_gateway_integration.task.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "task" {
  rest_api_id = aws_api_gateway_integration.task.rest_api_id
  resource_id = aws_api_gateway_integration.task.resource_id
  http_method = aws_api_gateway_integration.task.http_method
  status_code = aws_api_gateway_method_response.task.status_code

  response_templates = {
    "application/json" = ""
  }

  depends_on = [
    aws_api_gateway_integration.task
  ]
}
