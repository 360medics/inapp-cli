# Internal team documentation

## Introduction

We use a larger infrastructure that receive task definitions, [read more about it here](https://github.com/360medics/inapp-infrastructure-definition).

This folder contains:

- A terraform module that defines the task and resources needed to deploy the backend.
- A builder that builds the backend and push it to the ECR (`build-images.sh`).

## Terraform Module

### Overview

- an ECS Service which belongs to [this ECS Cluster](https://github.com/360medics/inapp-infrastructure-definition). Listening to the NLB and targeting the Fargate container. It has other options that you could see in the file
- a Task Definition (Fargate) which belongs to the previously defined ECS Service. This task declare some containers (in this example only one) that run an application (in this case, the backend)
- creating basic roles for tasks. Actually it only create role that allow logging and access to the ECR.
- defining the security rules for the task, actually allow ingress on port 4000 (tcp) and allow egress for all ports/protocols.
- a NLB listener on port 1025 which redirect to the NLB target group (the ecs service) on port 4000
- the routing definition for the API Gateway, basically it catch all HTTP method (ANY) on all `/project_name/*` path, and redirecting to the NLB via VPC link ([see diagram](https://github.com/360medics/inapp-infrastructure-definition)) on port 1025 (the same as NLB listener)

### Requirements

- Terraform

## Builder

### Requirements

- aws cli, used to get the repository URL.
- access and secret key to access the repository, the user/policy is defined [here](https://github.com/360medics/inapp-infrastructure-definition/blob/master/users.tf).
- docker, used to build the backend image.

### Troubleshooting

- On Mac (we love :apple:, right ?), the default `nohup` command isn't the official, instead, you should install `coreutils` (`brew install coreutils`), which provide a command named `gnohup` which is the official one. After this, we recommand setting an alias from `nohup` to `gnohup`.
