# Internal team documentation

## Introduction

We use a larger infrastructure that receive task definitions, [read more about it here](https://github.com/360medics/inapp-infrastructure-definition).

This folder contains:

- A terraform module that defines the task and resources needed to deploy the backend and the frontend application into the AWS infrastructure
- A builder building the backend application and pushing the built docker image to the ECR (`build-images.sh`)
- A deploy client application script that build `client` application and deploys it to the S3 bucket defined in the `front.tf` file
## Requirements

- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started#install-terraform) (1+)
- Python (not python3 but python)
- [AWS CLI](https://docs.aws.amazon.com/fr_fr/cli/latest/userguide/install-cliv2.html) (2+)
- [Docker](https://docs.docker.com/get-docker/), used to build the backend image
- Access and Secret key to interract with aws resources, written to `.env` in the root project folder
- [CircleCI token](https://circleci.com/docs/2.0/managing-api-tokens/#creating-a-personal-api-token), written to `.env` in the root project folder

## Terraform Module

### Overview

#### Backend

- an ECS Service which belongs to [this ECS Cluster](https://github.com/360medics/inapp-infrastructure-definition). Listening to the NLB and targeting the Fargate container. It has other options that you could see in the file
- a Task Definition (Fargate) which belongs to the previously defined ECS Service. This task declare some containers (in this example only one) that run an application (in this case, the backend)
- creating basic roles for tasks. Actually it only create role that allow logging and access to the ECR
- defining the security rules for the task, actually allow ingress on port 4000 (tcp) and allow egress for all ports/protocols
- a NLB listener on port x (x > 1025) which redirect to the NLB target group (the ecs service) on port 4000. :warning: the port should be different for each application
- the routing definition for the API Gateway, basically it catch all HTTP method (ANY) on all `inapps/project_name/api/*` path, and redirecting to the NLB via VPC link ([see diagram](https://github.com/360medics/inapp-infrastructure-definition)) on port 1025 (the same as NLB listener)
- a Postgres user / database pair that will be used by the backend application. Note that the main RDS instance is partitioned into multiple databases (one per application)

#### Frontend

- An S3 Bucket that will store the static files.
- API Gateway routes targetting the S3 Bucket.

### Troubleshooting

- On Mac (we love :apple:, right ?), the default `nohup` command isn't the official, instead, you should install `coreutils` (`brew install coreutils`), which provide a command named `gnohup` which is the official one. After this, we recommand setting an alias from `nohup` to `gnohup`.
