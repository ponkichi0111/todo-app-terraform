# ToDoアプリを作成

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
