#!/bin/bash

set -e

DBH=$(terraform -chdir=infra/terraform/app output -json | jq -r '.rds_endpoint.value')
DBN=$(terraform -chdir=infra/terraform/app output -json | jq -r '.rds_db_name.value')
DBU=$(terraform -chdir=infra/terraform/shared output -json | jq -r '.db_user_arn.value')
DBP=$(terraform -chdir=infra/terraform/shared output -json | jq -r '.db_password_arn.value')
ECRB=$(terraform -chdir=infra/terraform/shared output -json | jq -r '.ecr_backend_repo_name.value')
ECRF=$(terraform -chdir=infra/terraform/shared output -json | jq -r '.ecr_frontend_repo_name.value')
IRA=$(terraform -chdir=infra/terraform/shared output -json | jq -r '.ecs_app_task_role_arn.value')
IRT=$(terraform -chdir=infra/terraform/shared output -json | jq -r '.ecs_task_execution_role_arn.value')
CWB=$(terraform -chdir=infra/terraform/app output -json | jq -r '.backend_log_group_name.value')
CWF=$(terraform -chdir=infra/terraform/app output -json | jq -r '.frontend_log_group_name.value')


env \
  DB_HOST="$DBH" \
  DB_NAME="$DBN" \
  DB_USER="$DBU" \
  DB_PASSWORD="$DBP" \
  ECR_BACKEND_REPO_NAME="$ECRB" \
  ECR_FRONTEND_REPO_NAME="$ECRF" \
  IAM_ROLE_APP_TASK="$IRA" \
  IAM_ROLE_TASK_EXECUTION="$IRT" \
  CLOUDWATCH_LOG_BACKEND="$CWB" \
  CLOUDWATCH_LOG_FRONTEND="$CWF" \
  envsubst < .ecspresso/task-def.json.tpl > .ecspresso/task-def.json

chmod 644 .ecspresso/task-def.json
