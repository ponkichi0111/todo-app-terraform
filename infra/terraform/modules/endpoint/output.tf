output "s3_vpc_endpoint_id" {
  value = aws_vpc_endpoint.s3.id
}

output "ecr_api_vpc_endpoint_id" {
  value = aws_vpc_endpoint.interface["com.amazonaws.${var.aws_region}.ecr.api"].id
}

output "ecr_dkr_vpc_endpoint_id" {
  value = aws_vpc_endpoint.interface["com.amazonaws.${var.aws_region}.ecr.dkr"].id
}