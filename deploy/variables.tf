variable "env" {
  default     = "dev"
  description = "Environment in which to deploy"
  type        = string
}

variable "project" {
  default     = "test"
  description = "Project name"
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
variable "aws_profile" {
  default     = "ac-dev"
  description = "AWS profile to use for deployment and access to S3 state bucket"
  type        = string
}
