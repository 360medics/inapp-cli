#!/bin/bash

# stack
rsync -av --progress ./stacks/client/ ./cli/boilerplate/stacks/client/ --exclude node_modules --exclude dist
rsync -av --progress ./stacks/api/ ./cli/boilerplate/stacks/api/ --exclude node_modules

# deploy
rsync -av --progress ./deploy/ ./cli/boilerplate/deploy/ --exclude state --exclude .terraform
