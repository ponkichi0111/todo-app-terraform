resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [var.private_route_table_id]

  tags = {
    Name = "${var.name_prefix}-vpce-s3"
  }
}

# ループで VPC エンドポイントを作成
locals {
  interface_services = [
    "com.amazonaws.ap-northeast-1.secretsmanager",
    "com.amazonaws.ap-northeast-1.ecr.api",
    "com.amazonaws.ap-northeast-1.ecr.dkr",
    "com.amazonaws.ap-northeast-1.logs",
    "com.amazonaws.ap-northeast-1.sts"
  ]
  short_names = {
    for svc in local.interface_services :
    svc => join(".", slice(split(".", svc), 3, length(split(".", svc))))
  }
}

resource "aws_vpc_endpoint" "interface" {
  for_each = toset(local.interface_services)

  vpc_id             = var.vpc_id
  service_name       = each.key
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.private_subnet_ids
  security_group_ids = [aws_security_group.vpc_endpoint.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.name_prefix}-${local.short_names[each.key]}"
  }
}