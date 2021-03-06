#!/bin/bash

package="360medics.com/inapp-cli/v2"
package_name="inapp-cli"

platforms=("windows/amd64" "windows/386" "darwin/amd64" "linux/amd64" "linux/386")

for platform in "${platforms[@]}"
do
  platform_split=(${platform//\// })
  GOOS=${platform_split[0]}
  GOARCH=${platform_split[1]}

  output_name=$package_name'-'$GOOS'-'$GOARCH

  if [ $GOOS = "windows" ]; then
      output_name+='.exe'
  fi

  env GOOS=$GOOS GOARCH=$GOARCH go build -o dist/$output_name $package

  if [ $? -ne 0 ]; then
    echo 'An error has occurred! Aborting the script execution...'
    exit 1
  fi
done