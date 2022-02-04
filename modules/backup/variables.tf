variable "backup_bucket_name" {
  type        = string
  description = "The S3 bucket where the backups are going to be stored"
}
variable "backup_folder" {
  type        = string
  description = "The folder where to store the backups"
}
variable "cf_zone" {
  type        = string
  description = "Domain name located in CloudFlare (e.g. gustavobelfort.dev):"
}

variable "sender_email" {
  type        = string
  description = "Email from which to send the daily summary"
}

variable "recipient_email" {
  type        = string
  description = "Email from which to send the daily summary"
}

variable "log_file_name" {
  type        = string
  description = "Log file name in the format https___<subdomain>_<domain>_<tld>_production.log"
}
