variable "tag_terraform-stackid" {
  description = "Tag to append to each resource for the AWS project name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets where the ghost instances will be deployed"
  type        = list(string)
}

variable "database_subnets" {
  description = "Private subnets where the RDS instance will be deployed"
  type        = list(string)
}

variable "your_public_ip" {
  description = "Your Public IP Address: (X.X.X.X)"
  type        = string
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}
