variable "backend_cw_name" {
  description     = "The name of the CloudWatch log group for the backend service"
  type            = string
}

variable "frontend_cw_name" {
  description     = "The name of the CloudWatch log group for the frontend service"
  type            = string
}