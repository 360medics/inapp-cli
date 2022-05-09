terraform {
  cloud {
    organization = "360medics"

    workspaces {
      tags = ["inapp-{{.Name}}"]
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql",
      version = "~> 1.14.0"
    }
    circleci = {
      source  = "mrolla/circleci"
      version = "0.6.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}

module "db_tunnel" {
  source = "git::git@github.com:360medics/terraform-ssh-tunnel.git"

  target_host = data.aws_db_instance.main.address
  target_port = data.aws_db_instance.main.port

  gateway_host = data.aws_instance.bastion.public_ip
  gateway_user = "ubuntu"

  ssh_cmd = "ssh -i /tmp/bastion.pem -o StrictHostKeyChecking=no"
}

provider "postgresql" {
  alias     = "tunnel"
  host      = module.db_tunnel.host
  port      = module.db_tunnel.port
  username  = "root"
  password  = "notsecure"
  superuser = false
  sslmode   = "disable"
}

provider "circleci" {
  api_token    = var.circleci_token
  organization = var.circleci_organization_name
}

# data "circleci_context" "task" {
#   name = var.circleci_context_name
# }

// http://mydomain.com/inapps/${inapp-name} endpoint
resource "aws_api_gateway_resource" "task-root" {
  rest_api_id = data.aws_api_gateway_rest_api.main.id
  parent_id   = data.aws_api_gateway_resource.inapps-root.id

  path_part = var.project
}

output "host" {
  value = module.db_tunnel.host
}

output "port" {
  value = module.db_tunnel.port
}
