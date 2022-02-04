/*--------------------------------------------------------------------------------------------------
  Network
--------------------------------------------------------------------------------------------------*/
variable "vpc_cidr" {
  type        = string
  description = "Network block for your VPC in CIDR format (X.X.X.X/XX):"
  default     = "10.0.0.0/16"
}
variable "public_subnets" {
  description = "Public subnets where the ghost instances will be deployed"
  type        = list(string)
  default     = ["10.0.101.0/24"]
}
variable "database_subnets" {
  description = "Private subnets where the RDS instance will be deployed"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b"]
}
variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "ghost_vpc"
}
/*--------------------------------------------------------------------------------------------------
  RDS
--------------------------------------------------------------------------------------------------*/
variable "db_pass" {
  type        = string
  sensitive   = true
  description = "Set a new password for the root database user. Note: Ghost will temporarily use these credentials to create its database and own user account to use going forward:"
}
variable "db_user" {
  type        = string
  description = "Set master database username:"
  default     = "root"
}
variable "db_name" {
  type        = string
  description = "Name of the new database that Ghost will use:"
  default     = "website_prod"
}
variable "mysql_engine_version" {
  description = "Versions available: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html"
  type        = string
  default     = "5.7"
}
variable "mysql_instance_class" {
  description = "MySQL instance class, only db.t2.micro is free tier eligible"
  type        = string
  default     = "db.t2.micro"
}
variable "mysql_parameter_group_name" {
  description = "Mysql parameter group name"
  type        = string
  default     = "default.mysql5.7"
}
variable "mysql_allocated_storage" {
  description = "Mysql db allocated storage size"
  default     = 20
  type        = number
}
variable "mysql_storage_type" {
  description = "Mysql db storage type"
  default     = "gp2"
  type        = string
}
variable "mysql_maintenance_window" {
  description = "Mysql db maintenance window"
  default     = "Mon:00:00-Mon:03:00"
  type        = string
}
variable "mysql_backup_retention_period" {
  description = "Mysql db backup retention period"
  default     = 30
  type        = number
}

/*--------------------------------------------------------------------------------------------------
  AWS 
--------------------------------------------------------------------------------------------------*/
variable "aws_profile" {
  type        = string
  description = "The name of the AWS Profile to use from your machine:"
  default     = "default"
}
variable "aws_region" {
  type        = string
  description = "The AWS Region (e.g. us-east-2, ap-southeast-2):"
  default     = "us-east-2"
}
variable "tag_terraform-stackid" {
  type        = string
  description = "The AWS resource tag applied to resources in this deployment:"
  default     = "blog"
}

/*--------------------------------------------------------------------------------------------------
  EC2
--------------------------------------------------------------------------------------------------*/
variable "ec2_keypair" {
  type        = string
  description = "Your public key for SSH connectivity to EC2 (e.g. sha-rsa...):"
}
variable "instance_size" {
  type        = string
  description = "Type of EC2 Instance (e.g. t3a.micro, t3a.small, t3.micro):"
  default     = "t2.micro"
}
variable "sys_username" {
  type        = string
  description = "Username for the account:"
  default     = "ubuntu"
}
variable "log_file_name" {
  type        = string
  description = "Ghost log file name in the format https___<subdomain>_<domain>_<tld>_production.log"
}
variable "attachment_type" {
  type        = string
  description = "Type of the attachment to send in the daily summaries"
  default     = "text/plain"
}


/*--------------------------------------------------------------------------------------------------
  User data vars
--------------------------------------------------------------------------------------------------*/
variable "ssl_email" {
  type        = string
  sensitive   = true
  description = "Email address to receive Let's Encrypt expiry notifications:"
}
variable "your_public_ip" {
  type        = string
  description = "Your Public IP Address: (X.X.X.X)"
}
variable "sender_email" {
  type        = string
  description = "Email from which to send the alarms"
}
variable "recipient_email" {
  type        = string
  description = "Email in which to receive the alarms and summary"
}

/*--------------------------------------------------------------------------------------------------
  Cloudflare
--------------------------------------------------------------------------------------------------*/
variable "cf_email" {
  type        = string
  description = "Your Cloudflare email address:"
  sensitive   = true
}
variable "cf_apikey" {
  type        = string
  description = "Your Cloudflare API Key:"
  sensitive   = true
}
variable "cf_zone_id" {
  type        = string
  sensitive   = true
  description = "CloudFlare Zone ID for the domain name:"
}
variable "cf_zone" {
  type        = string
  description = "Domain name located in CloudFlare (e.g. gustavobelfort.dev):"
  default     = "gustavobelfort.dev"
}
variable "subdomain" {
  type        = string
  description = "Subdomain for your website (Default: 'blog'):"
  default     = "blog"
}

/*--------------------------------------------------------------------------------------------------
  Backup
--------------------------------------------------------------------------------------------------*/
variable "backup_bucket_name" {
  type        = string
  description = "The S3 bucket where the backups are going to be stored"
  default     = "gustavo-ghost-bucket"
}
variable "backup_folder" {
  type        = string
  description = "The folder where to store the backups"
  default     = "backup"
}
