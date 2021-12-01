#!/bin/sh

# load .env from root project directory
export $(egrep -v '^#' ../.env | xargs)

USAGE="Usage: build-images.sh [IMAGE_NAME:TAG].\n\tIMAGE_NAME:TAG - image name and tag to build.\n\t\tBy default, it will look at PROJECT_NAME env var first."

if { [ -z "$1" ] && [ -z "$PROJECT_NAME" ] ;}
  then
    echo $USAGE
    exit 1
fi

if [ -z "$PROJECT_NAME" ]
  then
    PROJECT_NAME=$1
fi

# dynamically create a state directory to share between scripts
mkdir -p state

# get container repository URL and store it in a file
# (region is not needed because defined in env var)
aws ecr describe-repositories --repository-name inapps-back | jq -r '.repositories[0].repositoryUri' > state/ecr-repo-url.txt
# get the variable we just stored
ecr_url=`cat state/ecr-repo-url.txt`

# build API image
docker build ../stacks/api -f ../stacks/api/Dockerfile.prod --tag inapps-back:$PROJECT_NAME

# login to the EC registry
# (region is not needed because defined in env var)
aws ecr get-login-password | docker login --username AWS --password-stdin $ecr_url

# weird, but we need to tag the image with the full URL
docker tag inapps-back:$PROJECT_NAME $ecr_url:$PROJECT_NAME

# push it to the private registry we've previously logged in to
docker push $ecr_url:$PROJECT_NAME