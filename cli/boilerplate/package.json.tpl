{
  "name": "inapp-{{.Name}}",
  "private": true,
  "version": "0.0.1",
  "description": "This is the {{.Name}} InApp for 360medics. It is under a no license, meaning all the work is copyrighted by 360medics.",
  "scripts": {
    "up": "gulp up",
    "down": "gulp down",
    "postinstall": "gulp install"{{if .Backend}},
    "prisma:migrate:dev": "npm run prisma:migrate:dev --prefix ./stacks/api",
    "prisma:migrate:reset": "npm run prisma:migrate:reset --prefix ./stacks/api",
    "prisma:generate": "npm run prisma:generate --prefix ./stacks/api"{{end}}
  },
  "author": "360medics",
  "license": "UNLICENSED",
  "devDependencies": {
    "@types/dotenv": "^8.2.0",
    "@types/gulp": "^4.0.9",
    "gulp": "^4.0.0",
    "ts-node": "^10.4.0",
    "typescript": "^4.5.2"
  },
  "dependencies": {
    "dotenv": "^10.0.0"
  }
}
