#!/bin/sh

# load .env from root project directory
set -a # automatically export all variables
source ../.env
set +a

needed_vars=(
  "AWS_ACCESS_KEY_ID"
  "AWS_SECRET_ACCESS_KEY"
  "CIRCLE_CI_TOKEN"
  "PROJECT_NAME"
  "NLB_LISTENER_PORT"
)

check_missing_env_var() {
  for var in "${needed_vars[@]}"; do
    if [ -z "${!var}" ]; then
      echo "Missing environment variable: $var"
      exit 1
    fi
  done
}

check_missing_env_var

set +e

echo "Creating CircleCI Context"
circleci context create gh 360medics inapps-$PROJECT_NAME || echo "Context already exists"

echo "Creating CircleCI Secret variables"
echo $AWS_ACCESS_KEY_ID | circleci context store-secret gh 360medics inapps-$PROJECT_NAME AWS_ACCESS_KEY_ID
echo $AWS_SECRET_ACCESS_KEY | circleci context store-secret gh 360medics inapps-$PROJECT_NAME AWS_SECRET_ACCESS_KEY
echo $CIRCLE_CI_TOKEN | circleci context store-secret gh 360medics inapps-$PROJECT_NAME CIRCLE_CI_TOKEN
echo $PROJECT_NAME | circleci context store-secret gh 360medics inapps-$PROJECT_NAME PROJECT_NAME
echo $NLB_LISTENER_PORT | circleci context store-secret gh 360medics inapps-$PROJECT_NAME NLB_LISTENER_PORT