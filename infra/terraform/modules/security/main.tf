resource "aws_security_group" "endpoint" {
  name = "${var.name_prefix}-endpoint-sg"
  description = "SG for VPC endpoint"
  vpc_id = var.vpc_id

  egress = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-endpoint-sg"
  }
}