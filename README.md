# ToDoアプリを作成

## ディレクトリ構成
<details>
<summary>クリックして展開</summary>
<pre>
.
├── .github
│   └── pull_request_template.md
├── .ecspresso
│   ├── config.yml
│   ├── service-def.json
│   ├── service-def.json.tpl
│   ├── task-def.json
│   └── task-def.json.tpl
├── app
│   ├── backend
│   │   ├── Dockerfile
│   │   ├── package.json
│   │   └── src
│   │       ├── index.js
│   │       ├── models
│   │       │   └── db.js
│   │       └── routes
│   │           └── todos.js
│   ├── docker-compose.yml
│   ├── frontend
│   │   ├── Dockerfile
│   │   ├── index.html
│   │   ├── nginx.conf
│   │   └── script.js
│   └── mysql
│       └── init.sql
├── infra
│   └── terraform
│       ├── app
│       │   ├── backend.tf
│       │   ├── main.tf
│       │   ├── output.tf
│       │   ├── terraform.tf
│       │   ├── terraform.tfvars
│       │   └── variables.tf
│       ├── backend
│       │   ├── main.tf
│       │   ├── terraform.tfstate
│       │   ├── terraform.tfstate.backup
│       │   ├── terraform.tfvars
│       │   └── variables.tf
│       ├── modules
│       │   ├── alb
│       │   │   ├── main.tf
│       │   │   ├── output.tf
│       │   │   └── variables.tf
│       │   ├── ecr
│       │   │   ├── main.tf
│       │   │   ├── output.tf
│       │   │   └── variables.tf
│       │   ├── ecs
│       │   │   ├── main.tf
│       │   │   ├── output.tf
│       │   │   └── variables.tf
│       │   ├── endpoint
│       │   │   ├── main.tf
│       │   │   ├── output.tf
│       │   │   └── variables.tf
│       │   ├── iam
│       │   │   ├── main.tf
│       │   │   ├── output.tf
│       │   │   └── variables.tf
│       │   ├── rds
│       │   │   ├── main.tf
│       │   │   ├── output.tf
│       │   │   └── variables.tf
│       │   ├── secrets
│       │   │   ├── main.tf
│       │   │   ├── output.tf
│       │   │   └── variables.tf
│       │   ├── security
│       │   │   ├── main.tf
│       │   │   ├── output.tf
│       │   │   └── variables.tf
│       │   └── vpc
│       │       ├── main.tf
│       │       ├── output.tf
│       │       └── variables.tf
│       └── shared
│           ├── backend.tf
│           ├── main.tf
│           ├── terraform.tf
│           ├── terraform.tfvars
│           └── variables.tf
├── README.md
└── scripts
    ├── gen-service-def.sh
    └── gen-task-def.sh
</pre>
</details>

## 事前準備
・アクセスキーを使用せずにterraformを実行するため、AWS IAM Identity Centerを利用する。
1. **Identity Centerでユーザー作成**
- Terraformを実行するための専用ユーザーをAWS Identity Centerで作成

2. **ローカル設定**
- [~/.aws/config]にアカウントID、ロール名を追加
  ```
  [profile terraform-admin]
  sso_start_url = https://my-sso-portal.awsapps.com/start
  sso_region = ap-northeast-1
  sso_account_id = 123456789012
  sso_role_name = TerraformDeployerRole
  region = ap-northeast-1
  output = json
  ```

3. **SSOに接続**
```
export AWS_PROFILE=terraform-admin
aws sso login --profile terraform-admin
```


## ToDoアプリ作成
DBユーザーに CREATE DATABASE 権限を付与  
・Prisma がシャドウDBを自動作成できるようするため  
`docker compose exec db mysql -uroot -proot`  
```
GRANT ALL PRIVILEGES ON *.* TO 'user'@'%';
FLUSH PRIVILEGES;
EXIT;
```

## ECRプッシュ
・イメージはARMアーキテクチャ(amd64)にする必要がある
`docker build --platform linux/amd64 -t todo-backend .`  

## Ecsporesso構築
タスク/サービスはjson形式で記載。
ecspresso は内部的に YAML を読み込んでから JSON に変換して処理します（なぜなら AWS の API は JSON を受け取るため）。
yamlからjsonjに変換する際に、構文的には正しくても ecspresso 側が誤解釈する値がある。
YAML の中に - を含む値などが該当する。
基本的にawsのリソースIDは[-]が含まれるケースが多いため、jsonを使用

・ecspressoのデプロイ

・サービス削除  
1.サービスをスケールダウン（desiredCount = 0）  
`ecspresso scale --tasks=0 --config .ecspresso/config.yml`  
2.サービス削除  
`ecspresso delete --config .ecspresso/config.yml`  