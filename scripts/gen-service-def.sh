#!/bin/bash

set -e

# Terraform output から値を取得
TGA=$(terraform -chdir=infra/terraform/app output -json | jq -r '.target_group_arn.value')
SUB1=$(terraform -chdir=infra/terraform/app output -json | jq -r '.subnet_ids.value[0]')
SUB2=$(terraform -chdir=infra/terraform/app output -json | jq -r '.subnet_ids.value[1]')
SG=$(terraform -chdir=infra/terraform/app output -json | jq -r '.security_group_ids.value')

# JSONテンプレートを置換して service-def.json を生成
env \
  TARGET_GROUP_ARN="$TGA" \
  SUBNET_1="$SUB1" \
  SUBNET_2="$SUB2" \
  SECURITY_GROUP_ID="$SG" \
  envsubst < .ecspresso/service-def.json.tpl > .ecspresso/service-def.json

chmod 644 .ecspresso/service-def.json
