version: "3"

services:{{if .Backend}}
  db:
    image: postgres:13-alpine
    restart: always
    env_file:
      - .env
    ports:
      - ${PG_PORT}:${PG_PORT}
    volumes:
      - db_data:/var/lib/postgresql/data

  api:
    build:
      context: ./stacks/api
      dockerfile: docker/Dockerfile.dev
    restart: always
    ports:
      - ${API_PORT}:${API_PORT}
    volumes:
      - ./stacks/api/src:/opt/api/src
      - ./stacks/api/node_modules/@prisma/client:/opt/api/node_modules/@prisma/client
    env_file:
      - .env
    environment:
      - DATABASE_URL=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${PG_HOST}:${PG_PORT}/${POSTGRES_DB}?schema=public{{end}}
  {{if .Frontend}}
  client:
    build:
      context: ./stacks/client
      dockerfile: docker/Dockerfile.dev
    restart: always
    ports:
      - ${CLIENT_PORT}:${CLIENT_PORT}
    volumes:
      - ./stacks/client/src:/opt/client/src
      - ./stacks/client/public:/opt/client/public
    environment:
      - PORT=${CLIENT_PORT}
      - VUE_APP_API_URL=http://localhost:${API_PORT}{{end}}
{{if .Backend}}volumes:
  db_data:
{{end}}