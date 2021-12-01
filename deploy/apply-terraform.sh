#!/bin/sh

# load .env from root project directory
export $(egrep -v '^#' ../.env | xargs)

export TF_VAR_access_key=${AWS_ACCESS_KEY_ID}
export TF_VAR_secret_key=${AWS_SECRET_ACCESS_KEY}

terraform apply