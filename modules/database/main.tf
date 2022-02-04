# Create a RDS Mysql Instance
resource "aws_db_instance" "mysql" {
  engine                  = "mysql"
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  username                = var.username
  password                = var.password
  parameter_group_name    = var.parameter_group_name
  vpc_security_group_ids  = [var.mysql_secgroup_id]
  maintenance_window      = var.maintenance_window
  backup_retention_period = var.backup_retention_period
  db_subnet_group_name    = var.database_subnet_group_name
  skip_final_snapshot     = true
}
