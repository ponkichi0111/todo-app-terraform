#!/bin/bash

set -e

# Terraform output から値を取得
ALMDNS=$(terraform -chdir=infra/terraform/app output -json | jq -r '.alb_dns_name.value')

# JSONテンプレートを置換して service-def.json を生成
env \
  ALB_DNS="$ALMDNS" \
  envsubst < app/frontend/nginx.conf.tpl > app/frontend/nginx.conf

chmod 644 app/frontend/nginx.conf
