variable "engine_version" {
  description = "Versions available: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html"
  type        = string
}

variable "instance_class" {
  description = "MySQL instance class, only db.t2.micro is free tier eligible"
  type        = string
}

variable "username" {
  description = "MySQL admin username"
  type        = string
  sensitive   = true
}

variable "password" {
  description = "MySQL password"
  type        = string
  sensitive   = true
}

variable "parameter_group_name" {
  description = "Mysql parameter group name"
  type        = string
}

variable "allocated_storage" {
  description = "Mysql db allocated storage size"
  type        = string
}

variable "storage_type" {
  description = "Mysql db storage type"
  type        = string
}

variable "maintenance_window" {
  description = "Mysql db maintenance window"
  type        = string
}

variable "backup_retention_period" {
  description = "Mysql db backup retention period"
  type        = string
}

variable "mysql_secgroup_id" {
  type        = string
  description = "Security Group ID injected from the network module."
}

variable "database_subnet_group_name" {
  type        = string
  description = "Name of the database subnet group"
}
