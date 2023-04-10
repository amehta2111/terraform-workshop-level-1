locals {
  resource_name_prefix = var.resource_tag_name
  db_creds             = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)
}

resource "aws_security_group" "rds-sg" {
  name = "${local.resource_name_prefix}-rds-sg"

  description = "RDS (terraform-managed)"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = var.rds_port
    to_port     = var.rds_port
    protocol    = "tcp"
    cidr_blocks = [var.prv_sub1_cidr_block, var.prv_sub2_cidr_block]
    description = "Allow access from ec2 instance to rds"
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
    description = "Allow access from ec2 instance to rds"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${local.resource_name_prefix}-${var.rds_identifier}-subnet-group"
  subnet_ids = [aws_subnet.prv_sub1.id, aws_subnet.prv_sub2.id]
}

resource "aws_db_instance" "rds-instance" {
  identifier = "${local.resource_name_prefix}-${var.rds_identifier}"

  allocated_storage    = var.rds_allocated_storage
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.id
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  instance_class       = var.rds_instance_class
  db_name              = var.rds_name
  username             = local.db_creds.username
  password             = local.db_creds.password
  port                 = var.rds_port
  publicly_accessible  = var.publicly_accessible
  storage_encrypted    = var.rds_storage_encrypted
  storage_type         = var.rds_storage_type
  skip_final_snapshot  = var.skip_final_snapshot

  vpc_security_group_ids = [aws_security_group.rds-sg.id]
}