# InApp CLI

## Installation

You can find binary on the realease page. You can install it manually or use one of the following commands, which downloads the binary and place it in `/usr/local/bin` which should be in your `PATH`.

- MacOS (darwin-amd64): `curl -SL https://github.com/360medics/inapp-template/releases/download/0.0.2/inapp-0.0.2-darwin-amd64.tar.gz | tar -zxC /usr/local/bin`
- Linux (linux-amd64): `curl -SL https://github.com/360medics/inapp-template/releases/download/0.0.2/inapp-0.0.2-linux-amd64.tar.gz | tar -zxC /usr/local/bin`

### Or, Build from source

Requirements:

- Go (1.17)

1. Clone the repository
2. Go to the `cli` sub-folder
3. `go build`

## Usage

`inapp create` is a command that will create a boilerplate for your InApp. Before getting started, you should know the project name and the type (`front`, `back` or `full`).

Example: `inapp create -n dev-logbook -t full`

You can get help for the command by using `inapp help`, or for a sub-command `inapp create --help`.

## Initiate the development automation

1. Create an AWS user with the same right as the terraform user
2. Create programmatic access for the user and place it in .env of the previously created projet (using the CLI)
3. Get a CircleCI Token and place it in .env of the previously created projet (using the CLI)
4. Fill the `NLB_LISTENER_PORT` value in .env of the previously created projet (using the CLI)
5. Run the `deploy/init.sh` script, this will create CircleCI context and place needed secret variables
6. Go to CircleCI interface and track the new project repository

# Contributing

## Introduction

This CLI should facilitate the creation of any future InApp. It create a boilerplate needed based on the InApp type, which also has the deployment (CI/CD) automation needed to deploy the InApp.

The boilerplates files are located in the `cli/boilerplate` folder and it's embed in the CLI binary.

But, in order to facilitate maintainability, we also kept a `full` InApp type at the project root. So we can clone this projet and edit the boilerplate files without having to generate an InApp.

## Scripts

`copy-to-boilerplate.sh` - Copy the stacks (`api` and `client`) and `deploy` to the boilerplate folder.

## Project Structure

- `cli` - The CLI Golang application, using [viper](https://github.com/spf13/viper) for configuration handling and [cobra](https://github.com/spf13/cobra) for CLI logic.
- `deploy` - The deployment logic for the InApp, which has one Terraform module and utility scripts.
- `stacks` - Contains InApp specific application, which usually is only `client` but can also be `api` when the InApp is full stack.

## Creating a new release

In order to create a new release that automatically builds the CLI and distribute binaries to the release assets folder, you'll need to manually create a new release with a version on GitHub.

When you're done, you probably should edit this README.md file to update binaries links.

# Need Help ?

You can get support by email at [tech@360medics.com](mailto:tech@360medics.com)
