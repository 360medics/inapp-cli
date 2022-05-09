#!/bin/zsh

set -a # automatically export all variables
source ../.env
set +a

echo "Installing NPM packages..."
npm i --quiet --progress false --prefix ../stacks/client

echo "Building VueJS client application..."
npm run build --prefix ../stacks/client --quiet

echo "Uploading files to S3 bucket 360-medics-inapp-$PROJECT_NAME..."
# cache on every resource but index.html for 24 hours (86400 seconds)
aws s3 sync ../stacks/client/dist s3://360-medics-inapp-$PROJECT_NAME \
  --exclude 'index.html' \
  --delete \
  --cache-control max-age=86400

# no cache on index.html
aws s3 sync ../stacks/client/dist s3://360-medics-inapp-$PROJECT_NAME \
  --include 'index.html' \
  --delete \
  --cache-control no-store
