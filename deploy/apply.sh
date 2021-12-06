#!/bin/sh

# load .env from root project directory
set -a # automatically export all variables
source ../.env
set +a

export TF_VAR_env=${ENV}
export TF_VAR_project=${PROJECT_NAME}

# AWS
export TF_VAR_access_key=${AWS_ACCESS_KEY_ID}
export TF_VAR_secret_key=${AWS_SECRET_ACCESS_KEY}
export TF_VAR_region=${AWS_DEFAULT_REGION}
export TF_VAR_state_bucket_name=${AWS_STATE_BUCKET_NAME}

export TF_VAR_nlb_listener_port=${NLB_LISTENER_PORT}

# Circle CI
export TF_VAR_circleci_token=${CIRCLECI_TOKEN}
export TF_VAR_circleci_organization_name=${CIRCLECI_ORGANIZATION_NAME}
export TF_VAR_circleci_context_name=${CIRCLECI_CONTEXT_NAME}

# Create identity to connect to bastion
aws secretsmanager get-secret-value --secret-id bastion_keys| jq --raw-output '.SecretString' | jq -r .private_key_pem > /tmp/bastion.pem
chmod 600 /tmp/bastion.pem

env

terraform init \
     -backend-config "bucket=$TF_VAR_state_bucket_name" \
     -backend-config "region=$TF_VAR_region" \
     -backend-config "key=tasks/$TF_VAR_project.$TF_VAR_env" \

terraform apply -auto-approve

# Remove identity
rm /tmp/bastion.pem