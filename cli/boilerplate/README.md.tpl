# InApp {{.Name}}

This template has been made for facilitating the creation of a new InApp project for 360medics. It is under a no license, meaning all the work is copyrighted by 360medics.

Please, read the whole `README` before starting to work on your project, this contains all the information you need to start, we will both benefit of it.

## A word about the stack

This stack contains:

{{if .Backend}}- A PostgreSQL 13 database, running on a Docker container on port `PG_PORT` (default: 5432). This database saves the data into a Docker volume.
- An API, running in a Docker container based on Node.js 16 on port `API_PORT` (default: 4000){{end}}
{{if .Frontend}}- A Client, running in a Docker container based on Node.js 16{{end}}

# Getting Started

## Requirements

- [Docker](https://www.docker.com/), se how to install it for [Mac](https://docs.docker.com/desktop/mac/install/), [Windows](https://docs.docker.com/desktop/windows/install/) or [Linux](https://docs.docker.com/engine/install/#server).
- [Docker compose plugin](https://docs.docker.com/compose/cli-command/#installing-compose-v2), if you're on MacOS or Windows, and you've installed Docker over Docker Desktop, you can safely ignore this step.
- [Node.js](https://nodejs.org/en/download/) (any version above 12 should be fine), if you've installed Node.js on Windows, make sure to install npm.

## Installation

1.  Build the stack and run it: `docker compose up -d --build`.
{{if .Backend}}2.  Execute database migrations using: `npm run prisma:migrate:dev` from the project root directory.{{end}}

# Development Workflow

**You DO NOT** push to the `master` / `main` branch.

You always create a branch from `master` ideally named `develop` and when you've finished, you create a PR from `develop` to `master`.

If it's possible, you should create small, incremental changes and commit them to `develop` branch that you will try to well name like: `feat(healer): add healer endpoint`. This is not mandatory, but it's a good practice. See more about [Conventional Commits here](https://www.conventionalcommits.org/en/v1.0.0/).

# Useful commands

{{if .Backend}}## Database Migrations

**DO NOT EXECUTE THIS ON PRODUCTION ENVIRONMENT**

`npm run prisma:migrate:dev`, from the project root directory: Create new migration file if needed, apply pending migrations and generate orm types and API.

`npm run prisma:generate`: Generate orm types and API.{{end}}
## Interact with the stack

Note: All `docker compose` commands must be launched from the project root directory.

### Start the stack

`docker compose up -d`, `-d` is for detached logs, but you can ommit it if you want to see the logs in the terminal, but do note that if you cancel the interactive mode, the stack will stop.

### Stop the stack

`docker compose down`, this will stop all containers and clean network, but it will not remove the volumes.

### Remove (completely) the stack

You might come at a point where you wrongly played with the stack, and you want to remove it.

`docker compose down --rmi all`, this will remove all containers, images, volumes and networks.

### See logs of a service

`docker compose logs -f <service>`, this will show the logs of the service, and will follow the logs.

### Remove all PostgreSQL datas

First of all, you have to stop the stack (see the command above). Then, you need to identify which volume holds the PostgreSQL data: `docker volume ls` will display all Docker volumes. Find the volume named something like `<project_name>_db_data`, and then run the following command: `docker volume rm <volume_name>`.

In order to re-create the volume with blank datas, just start the stack.

# Installing a new service dependency

You might want to add more project dependencies to a service:

1.  Navigate to the service you want `cd stacks/<service_name>`
2.  Run `npm i <new_dependency>`
3.  Rebuild the service with `docker compose build <service_name>`
4.  Update the service with `docker compose up -d <service_name>`

This will add the dependency to the service container as you've done it locally.

# Development setup recommendation

- An IDE that supports the [TypeScript](https://www.typescriptlang.org/) language is recommended (VSCode, Webstorm).
- Prettier and ESLint IDE extensions are recommended for code formatting / linting.
{{if .Frontend}}- Vetur extension is recommended for code intelligence on `client` project.{{end}}

# Sub-Projects

{{if .Backend}}[API](./stacks/api/README.md){{end}}

{{if .Frontend}}[Client](./stacks/client/README.md){{end}}
# Need Help ?

You can get support by email at [tech@360medics.com](mailto:tech@360medics.com)
