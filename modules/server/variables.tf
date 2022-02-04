variable "tag_terraform-stackid" {
  type        = string
  description = "Tag to append to each resource for the AWS project name"
}
variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
}
variable "subnet_id" {
  type        = string
  description = "Subnet ID injected from the network module."
}
variable "web_secgroup_id" {
  type        = string
  description = "Security Group ID injected from the network module."
}
variable "ec2_keypair" {
  type        = string
  description = "Your public key pair for SSH connectivity to EC2"
}
variable "cf_zone" {
  type        = string
  description = "Your DNS Zone in CloudFlare (e.g. gustavobelfort.dev)"
}
variable "db_name" {
  type        = string
  description = "The database name."
}
variable "db_pass" {
  type        = string
  description = "The database root password."
}
variable "db_host" {
  type        = string
  description = "The database host."
}
variable "ssl_email" {
  type        = string
  description = "The email address for monitoring certificate renewal alerts:"
}
variable "sys_username" {
  type        = string
  description = "Root admin system username:"
}
variable "subdomain" {
  type        = string
  description = "Subdomain for your website (Default: 'blog'):"
}
variable "aws_iam_instance_profile" {
  type        = string
  description = "EC2 ghost web server instance profile"
}
variable "backup_folder" {
  type        = string
  description = "The folder where to store the backups"
}
variable "backup_bucket_name" {
  type        = string
  description = "The S3 bucket where the backups are going to be stored"
}
variable "recipient_email" {
  type        = string
  description = "Email from which to send the alarms"
}
variable "aws_region" {
  type        = string
  description = "The AWS Region (e.g. us-east-2, ap-southeast-2)"
}
variable "log_file_name" {
  type        = string
  description = "Log file name in the format https___<subdomain>_<domain>_<tld>_production.log"
}
variable "sender_email" {
  type        = string
  description = "Email from which to send the daily summary"
}
variable "attachment_type" {
  type        = string
  description = "Type of the attachment to send in the daily summaries"
}
