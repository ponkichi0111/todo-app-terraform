variable "bucket_name" {
  type        = string
  description = "S3バケット名"
}

variable "lock_table_name" {
  type        = string
  description = "ロック管理用のDynamoDBテーブル名"
}

variable "environment" {
  type        = string
  default     = "dev"
}
