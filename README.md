# About this template

This template has been made for facilitating the creation of a new InApp project for 360medics. It is under a no license, meaning all the work is copyrighted by 360medics.

Please, read the whole `README` before starting to work on your project, this contains all the information you need to start, we will both benefit of it.

If you only need a frontend for your mission, you can go to `docker-compose.yaml` and safely remove `db` and `api` services from this file.

## A word about the stack

This stack contains:

- A PostgreSQL 13 database, running on a Docker container on port `PG_PORT` (default: 5432). This database saves the data into a Docker volume.
- An API, running on a Docker container based on Node.js 16 on port `API_PORT` (default: 4000)

# Getting Started

## Requirements

- [Docker](https://www.docker.com/), se how to install it for [Mac](https://docs.docker.com/desktop/mac/install/), [Windows](https://docs.docker.com/desktop/windows/install/) or [Linux](https://docs.docker.com/engine/install/#server).
- [Docker compose plugin](https://docs.docker.com/compose/cli-command/#installing-compose-v2), if you're on MacOS or Windows, and you've installed Docker over Docker Desktop, you can safely ignore this step.
- [Node.js](https://nodejs.org/en/download/) (any version above 12 should be fine), if you've installed Node.js on Windows, make sure to install npm.

## Installation

1.  You have to copy the `.env.local` file to `.env` file, this is the file that contains stack variables.

2.  Please, add a `PROJECT_NAME` value to the variables in the `.env` file, this will be used to create proper PostgreSQL database names.

3.  Run the following command to install the required dependencies `npm i`, this will install root project dependencies and all the sub-projects dependencies (thanks to postinstall script).

# Development Workflow

**You DO NOT** push to the `master` / `main` branch.

You always create a branch from `master` ideally named `develop` and when you've finished, you create a PR from `develop` to `master`.

If it's possible, you should create small, incremental changes and commit them to `develop` branch that you will try to well name like: `feat(healer): add healer endpoint`. This is not mandatory, but it's a good practice. See more about [Conventional Commits here](https://www.conventionalcommits.org/en/v1.0.0/).

# Using Prisma ORM (backend only)

If you are writing code into `stacks/api`, you might want to access database.

We've created a service under `stacks/api/src/internal/orm.service.ts` that export a variable named orm, it's an instanciated prisma client, and can be used like this:

```ts
import { orm } from "path/to/service/orm";

// replace $entity with the entity name (user, app, etc...)
const entity = await orm.$entity.findUnique({ where: { id: 1 } });
```

Prisma ORM documentation: https://www.prisma.io/docs/concepts/components/prisma-client/crud

## Modifying Database Schema

Before all things, backup the database data only (not schema).

If you need to add/edit/delete a part of the database schema, you might want to look at the `stacks/api/prisma/schema.prisma` file, it contains a declarative schema of the database. Prisma Schema documentation: https://www.prisma.io/docs/concepts/components/prisma-schema/data-model

Once you're done with your changes, you can run the following command to apply changes: `npm run prisma:migrate:dev`, from the project root directory.

If you failed and want to go back to the previous version, delete the generated migrations files under `stacks/api/prisma/migrations` and run `npm run prisma:migrate:reset` from the project root directory (All data will be lost), then import the backup file you saved before.

Make sure to commit the migrations files and the schema file changes.

# Useful commands

## Database Migrations (backend only)

**DO NOT EXECUTE THIS ON PRODUCTION ENVIRONMENT**

`npm run prisma:migrate:dev`, from the project root directory: Create new migration file if needed, apply pending migrations and generate orm types and API.

`npm run prisma:generate`: Generate orm types and API.

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
4.  Update the service with `docker-compose up -d <service_name>`

This will add the dependency to the service container as you've done it locally.

# Development setup recommendation

- An IDE that supports the [TypeScript](https://www.typescriptlang.org/) language is recommended (VSCode, Webstorm).
- Prettier and ESLint IDE extensions are recommended for code formatting / linting.

# Guidelines

[API](./stacks/api/GUIDELINE.md)

[Client](./stacks/client/GUIDELINE.md)

# Need Help ?

You can get support by email at [REPLACE_WITH_EMAIL](mailto:REPLACE_WITH_EMAIL)
