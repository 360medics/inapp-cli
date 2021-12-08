#!/bin/sh

set -a # automatically export all variables
source ../.env
set +a

echo "Installing NPM packages..."
npm i --quiet --progress false --prefix ../stacks/client

echo "Building VueJS client application..."
npm run build --prefix ../stacks/client --quiet

echo "Uploading files to S3 bucket 360-medics-inapp-$PROJECT_NAME..."
aws s3 sync ../stacks/client/dist s3://360-medics-inapp-$PROJECT_NAME --delete