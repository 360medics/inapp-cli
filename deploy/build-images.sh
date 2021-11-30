#!/bin/sh

# load .env
export $(egrep -v '^#' .env | xargs)

USAGE="Usage: build-images.sh [IMAGE_NAME:TAG]"

if [ -z "$1" ]
  then
    echo $USAGE
    exit 1
fi

# dynamically create a state directory to share between scripts
mkdir -p state

# get container repository URL and store it in a file
aws ecr describe-repositories --repository-name inapps-back | jq -r '.repositories[0].repositoryUri' > state/ecr-repo-url.txt
# get the variable we just stored
ecr_url=`cat state/ecr-repo-url.txt`

# build API image
docker build ../stacks/api -f ../stacks/api/Dockerfile.prod --tag inapps-back:$1

# login to the EC registry
# region is not needed because defined in env var
aws ecr get-login-password | docker login --username AWS --password-stdin $ecr_url

# docker tag inapp-back-$1:latest $ecr_url/ecr-main:latest
docker tag inapps-back:$1 $ecr_url:$1

# docker push $ecr_url/ecr-main:latest
docker push $ecr_url:$1