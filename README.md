## 概要
ECS Fargateを使用したコンテナベースのToDoアプリケーションを作成

## 技術スタック
- フロントエンド: HTML/JavaScript + Nginx
- バックエンド: Node.js
- データベース: MySQL 8.0
- インフラ: AWS (ECS)
- IaC: Terraform
- CI/CD: GitHub Actions

## ディレクトリ構成
<details>
<summary>クリックして展開</summary>
<pre>
.
├── .github
│   └── pull_request_template.md
│   └── workflows
│       ├── app-deploy.yml
│       ├── infra-deploy.yml
│       └── infra-destroy.yml
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
│   │   ├── nginx-dev.conf
│   │   ├── nginx-prd.conf
│   │   ├── nginx.conf.tpl
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
│       │   ├── cloudwatchlogs
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
│       │   ├── github_oidc
│       │   │   ├── main.tf
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
│       ├── shared
│       │   ├── backend.tf
│       │   ├── main.tf
│       │   ├── output.tf
│       │   ├── terraform.tf
│       │   ├── terraform.tfvars
│       │   └── variables.tf
│       └── terraform.tfstate
├── scripts
│   ├── gen-nginx-conf.sh
│   ├── gen-service-def.sh
│   └── gen-task-def.sh
└── README.md
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

## インフラ構成

### アーキテクチャ概要
- マルチAZ構成のサーバーレスアプリケーション
- フロントエンド/バックエンドをECS Fargateで実行
- プライベートサブネットにRDSを配置
- ALBを介してアプリケーションにアクセス

### 主要コンポーネント

#### ネットワーク (VPC)
- 2つのアベイラビリティゾーンに展開
- パブリックサブネット（10.0.1.0/24, 10.0.2.0/24）
  - ALBを配置
  - インターネットゲートウェイ経由で外部通信
- プライベートサブネット（10.0.101.0/24, 10.0.102.0/24）
  - ECSタスクとRDSを配置
  - VPCエンドポイント経由でAWSサービスにアクセス

#### コンピューティング (ECS)
- ECS Fargateでコンテナを実行
  - フロントエンドコンテナ (Nginx)
  - バックエンドコンテナ (Node.js)
- タスク定義
  - CPU: 512
  - メモリ: 1024MB

#### データベース (RDS)
- エンジン: MySQL 8.0
- インスタンスクラス: db.t4g.micro
- ストレージ: 20GB
- マルチAZ: 無効
- 自動バックアップ: 有効

#### ロードバランサー (ALB)
- パブリックサブネットに配置
- ヘルスチェック: /health
- ターゲットグループ: IPターゲット

#### セキュリティ
- セキュリティグループでアクセス制御
  - ALB: HTTP(80)のみ許可
  - ECS: ALBからのトラフィックのみ許可
  - RDS: ECSタスクからのMySQL(3306)のみ許可
- AWS Secrets Managerでデータベース認証情報を管理
- GitHub OIDC認証でGitHub Actionsからのデプロイを実行

#### モニタリング
- CloudWatch Logsでコンテナログを収集
  - フロントエンド: /ecs/todo-app/frontend
  - バックエンド: /ecs/todo-app/backend

## ECRプッシュ
イメージはx86_64アーキテクチャ(amd64)にする必要がある  
・バックエンド  
`docker build --platform linux/amd64 -t todo-backend .`  
・フロントエンド(本番環境のnginx.confを設定するため、環境変数を設定する)  
`docker build --build-arg ENV=prd --platform linux/amd64 -t todo-frontend .`  

## Ecspresso構築
タスク/サービスはjson形式で記載。  
ecspresso は内部的に YAML を読み込んでから JSON に変換して処理します（なぜなら AWS の API は JSON を受け取るため）。  
yamlからjsonjに変換する際に、構文的には正しくても ecspresso 側が誤解釈する値がある。  
YAML の中に - を含む値などが該当する。  
基本的にawsのリソースIDは[-]が含まれるケースが多いため、jsonを使用  

・ecspressoのデプロイ  
`ecspresso deploy --config .ecspresso/config.yml`  

・サービス削除  
1.サービスをスケールダウン（desiredCount = 0）  
`ecspresso scale --tasks=0 --config .ecspresso/config.yml`  
2.サービス削除  
`ecspresso delete --config .ecspresso/config.yml`  

## 作成したリソース情報

### AWSリソース
#### VPC
- **名前**: todo-vpc
- **CIDR**: `10.0.0.0/16`
- **サブネット**
  - **パブリックサブネット**: `10.0.1.0/24`, `10.0.2.0/24`
  - **プライベートサブネット**: `10.0.3.0/24`, `10.0.4.0/24`
- **インターネットゲートウェイ**: todo-igw
- **パブリックルートテーブル**: todo-public-rt
- **プライベートルートテーブル**: todo-private-rt

#### RDS
- **名前**: todo-db
- **エンジン**: MySQL 8.0
- **インスタンスクラス**: `db.t4g.micro`
- **ストレージ**: 20GB
- **エンドポイント**: `<RDSエンドポイント>`
- **セキュリティグループ**: `todo-database-sg`

#### ECS
- **クラスター名**: todo-ecs-cluster
- **タスク定義**
  - **名前**: todo-app-task
  - **コンテナ**
    - **todo-backend**
      - **イメージ**: `todo-backend:latest`
      - **ポート**: 4000
    - **todo-frontend**
      - **イメージ**: `todo-frontend:latest`
      - **ポート**: 80
- **サービス**
  - **名前**: todo-service
  - **ターゲットグループARN**: `<ターゲットグループARN>`
  - **サブネット**: `<サブネットID1>`, `<サブネットID2>`
  - **セキュリティグループ**: `todo-ecs-sg`

#### ALB
- **名前**: todo-alb
- **DNS名**: `<ALB DNS名>`
- **ターゲットグループ**
  - **名前**: todo-tg
  - **ポート**: 80
  - **ヘルスチェックパス**: `/`

#### ECR
- **リポジトリ**
  - **todo-backend**: `<ECRリポジトリURL>`
  - **todo-frontend**: `<ECRリポジトリURL>`

#### Secrets Manager
- **DBユーザーARN**: `<DBユーザーARN>`
- **DBパスワードARN**: `<DBパスワードARN>`

### Terraformバックエンド
- **S3バケット**: `terraform-state-todo-app-hiroyuki`
- **DynamoDBテーブル**: `terraform-lock`

### その他
- **Region**: `ap-northeast-1`