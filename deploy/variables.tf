variable "env" {
  default     = "dev"
  description = "Environment in which to deploy"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "state_bucket_name" {
  default     = "360-ac-terraform-states"
  description = "S3 bucket name that store terraform state"
  type        = string
}

variable "region" {
  default     = "eu-west-3"
  description = "AWS region to deploy infrastructure on"
  type        = string
}

variable "az" {
  default     = "eu-west-3a"
  description = "AWS availability zone to deploy networks on"
  type        = string
}

variable "aws_access_key" {
  default     = ""
  description = "AWS access key to use for deployment and access to S3 state bucket"
  type        = string
}

variable "aws_secret_key" {
  default     = ""
  description = "AWS secret key to use for deployment and access to S3 state bucket"
  type        = string
}

variable "nlb_listener_port" {
  type        = number
  description = "This should be unique for each project (task)"
  default     = 0
}

variable "circleci_token" {
  type        = string
  description = "CircleCI token to use to write context env variables"
  default     = ""
}

variable "circleci_organization_name" {
  type        = string
  description = "CircleCI Organization name"
  default     = ""
}

# variable "circleci_context_name" {
#   type        = string
#   description = "CircleCI Context name"
# }

variable "is_frontend" {
  default     = false
  type        = bool
  description = "Is this a frontend project?"
}

variable "is_backend" {
  default     = false
  type        = bool
  description = "Is this a backend project?"
}
