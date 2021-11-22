# Vue.js application for the client

This is a [Vue3](https://vuejs.org/) boilerplate application.

## Not familiar with Vue3 yet ?

[Please read this introduction](https://v3.vuejs.org/guide/migration/introduction.html)

## Files Structure

- `assets` contains static files to be served to the client (images, fonts, etc.)
- `components` contains components to be used in the Vue.js application
- `helpers` should only contains `.ts` file, and are util function to be used in components
- `router` contains routes declaration, see more in the [Vue Router](https://router.vuejs.org/)
- `scss` contains global styling
- `store` contains the global state of the application, but should not be used for passing props to child components
- `types` contains global types declaration
- `views` (pages), contains all pages used by the `router`

## Guidelines

[Here](./GUIDELINES.md) are some guidelines to follow when writing the client app.
