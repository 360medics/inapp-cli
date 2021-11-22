# Node.js application for the API

This is a [Node.js](https://nodejs.dev/) application using [Express](https://expressjs.com/), in [Typescript](https://www.typescriptlang.org/).

This application does hot-reload when a file changed in dev mode. Development mode is enabled by default.

## Files structure

```
.
├── prisma
│   ├── schema.prisma --> database schema
│   └── migrations --> migration files
├── scripts --> internal scripts
└── src
    ├── internal --> internal code
    ├── middleware --> global middlewares
    ├── routes --> API router
    │   └── user --> user router
    ├── app.ts --> express app definition
    └── index.ts --> server definition
```

## Routers

A router is a class exported by `express` for helping building API routes. It is declared for an URI route (eg. `/users`) and it can have sub-routes (eg. `/users/:id`). You can add more request handler to a router by using the router `.use()` method:

```ts
userRouter.get('/:userId', getUser);
```

There is a global router named: `apiRouter`, defined in `src/routes/index.ts`. This router should register every subrouters in `src/routes/*`.

## Request Handlers

A request handler is an interface that is used to handle a specific request. It is a function that takes a `Request` and a `Response` as parameters (and optionally a `next` function). Here is an example here:

```ts
// req and res parameter and automatically typed due to
// RequestHandler interface
export const getUser: RequestHandler = async (req, res) => {
  // retreive userId parameter
  const { userId } = req.params;

  // try to find one user with the given id
  const user = await orm.user.findUnique({ where: { id: userId } });

  // if user is not found, return 404
  if (!user) {
    return res.status(404).json({ message: 'User not found' });
  }

  return res.status(200).json({ user });
};
```

This example isn't good enought because it doesn't check if the given parameter `userId` is a valid id (a natural number [N] in this case).

Each path of a request handler should return a response, either a 2xx or a 4xx/5xx status code. See more about [HTTP status codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status).

## Middleware

A middleware is a function that is called before, between or after a request handler (usually it's before). It can be used to check for example if a user is authenticated or not before accessing a sub-router.

There are middleware registered by default (see more at `src/app.ts`):

- cors: allow cross-origin requests (by default `*`)
- helmet: set security headers
- bodyParser: parse request body / url-endcoded parameters
- morgan: log requests
- errorHandler: handle errors (return a 500 error if a route throws an error)

## Error handling

The request handlers should throws an error when something bad occurs:

```ts
throw new Error('Something really bad happended');
```

This error is handled by the `errorHandler` middleware.

# Interracting with Database

## Using Prisma ORM

If you are writing code into API, you might want to access database.

We've created a service under `/src/internal/orm.service.ts` that export a variable named orm, it's an instanciated prisma client, and can be used like this:

```ts
import { orm } from 'path/to/service/orm';

// replace $entity with the entity name (user, app, etc...)
const entity = await orm.$entity.findUnique({ where: { id: 1 } });
```

Prisma ORM documentation: https://www.prisma.io/docs/concepts/components/prisma-client/crud

## Modifying Database Schema

Before all things, backup the database data only (not schema).

If you need to add/edit/delete a part of the database schema, you might want to look at the `/prisma/schema.prisma` file, it contains a declarative schema of the database. Prisma Schema documentation: https://www.prisma.io/docs/concepts/components/prisma-schema/data-model

Once you're done with your changes, you can run the following command to apply changes: `npm run prisma:migrate:dev`, from the project root directory.

If you failed and want to go back to the previous version, delete the generated migrations files under `/prisma/migrations` and run `npm run prisma:migrate:reset` from the project root directory (All data will be lost), then import the backup file you saved before.

Make sure to commit the migrations files and the schema file changes.

## Commands

To be executed from the project root directory

**DO NOT EXECUTE THIS ON PRODUCTION ENVIRONMENT**

`npm run prisma:migrate:dev`, from the project root directory: Create new migration file if needed, apply pending migrations and generate orm types and API.

`npm run prisma:generate`: Generate orm types and API.

# Guidelines

[Here](./GUIDELINES.md) are some guidelines to follow when writing the API.
