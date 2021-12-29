### Keep this lower and kebab case (eg. log-book)
PROJECT_NAME={{.Name}}

### Backend application
API_PORT=4000
NODE_ENV=dev

### Front application
CLIENT_PORT=3000

### Database - Postgres
PG_HOST=db
PG_PORT=5432
POSTGRES_USER=api
POSTGRES_PASSWORD=notsecure
POSTGRES_DB=${PROJECT_NAME}
DATABASE_URL=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@localhost:${PG_PORT}/${POSTGRES_DB}?schema=public

### Deployment
ENV=dev
IS_FRONTEND={{if .Frontend}}true{{else}}false{{end}}
IS_BACKEND={{if .Backend}}true{{else}}false{{end}}
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_STATE_BUCKET_NAME=360-ac-terraform-states
AWS_DEFAULT_REGION=eu-west-3
ECR_REPOSITORY_NAME=inapps-back
CIRCLE_CI_TOKEN=
CIRCLECI_ORGANIZATION_NAME=360medics
CIRCLECI_CONTEXT_NAME=inapps-${PROJECT_NAME}

### This must be >1034 and should not already be used by the NLB on AWS
NLB_LISTENER_PORT=0000