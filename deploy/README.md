# Internal team documentation

## Introduction

We use a larger infrastructure that receive task definitions, [read more about it here](https://github.com/360medics/inapp-infrastructure-definition).

This folder contains:

- A terraform module that defines the task and resources needed to deploy the backend.
- A builder that builds the backend and push it to the ECR (`build-images.sh`).

## Terraform Module

### Requirements

- Terraform

## Builder

### Requirements

- aws cli, used to get the repository URL.
- access and secret key to access the repository, the user/policy is defined [here](https://github.com/360medics/inapp-infrastructure-definition/blob/master/users.tf).
- docker, used to build the backend image.
