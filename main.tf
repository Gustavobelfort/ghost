#Build the network as per the network module.
module "network" {
  vpc_name              = var.vpc_name
  source                = "./modules/network"
  tag_terraform-stackid = var.tag_terraform-stackid
  vpc_cidr              = var.vpc_cidr
  database_subnets      = var.database_subnets
  public_subnets        = var.public_subnets
  your_public_ip        = var.your_public_ip
  azs                   = var.azs
}

#Build the backup components as per the backup module.
module "backup" {
  source             = "./modules/backup"
  backup_bucket_name = var.backup_bucket_name
  backup_folder      = var.backup_folder
  sender_email       = var.sender_email
  cf_zone            = var.cf_zone
  recipient_email    = var.recipient_email
  log_file_name      = var.log_file_name
}

#Build the server as per the server module.
module "server" {
  source                   = "./modules/server"
  tag_terraform-stackid    = var.tag_terraform-stackid
  instance_type            = var.instance_size
  subnet_id                = module.network.public_subnet_ids
  web_secgroup_id          = module.network.web_secgroup_id
  ec2_keypair              = var.ec2_keypair
  cf_zone                  = var.cf_zone
  db_name                  = var.db_name
  db_pass                  = var.db_pass
  ssl_email                = var.ssl_email
  sys_username             = var.sys_username
  subdomain                = var.subdomain
  db_host                  = module.database.db_host
  backup_bucket_name       = var.backup_bucket_name
  backup_folder            = var.backup_folder
  aws_iam_instance_profile = module.backup.backup_iam_instance_profile
  recipient_email          = var.recipient_email
  sender_email             = var.sender_email
  aws_region               = var.aws_region
  log_file_name            = var.log_file_name
  attachment_type          = var.attachment_type
}

#Build the database as per the database module.
module "database" {
  source                     = "./modules/database"
  engine_version             = var.mysql_engine_version
  instance_class             = var.mysql_instance_class
  username                   = var.db_user
  password                   = var.db_pass
  parameter_group_name       = var.mysql_parameter_group_name
  allocated_storage          = var.mysql_allocated_storage
  storage_type               = var.mysql_storage_type
  maintenance_window         = var.mysql_maintenance_window
  backup_retention_period    = var.mysql_backup_retention_period
  mysql_secgroup_id          = module.network.mysql_secgroup_id
  database_subnet_group_name = module.network.database_subnet_group_name
}

#Build the services as per the services module.
module "services" {
  source         = "./modules/services"
  cf_zone        = var.cf_zone
  cf_zone_id     = var.cf_zone_id
  web_eip        = module.server.web_eip
  subdomain      = var.subdomain
  your_public_ip = var.your_public_ip
}
