output "web_secgroup_id" {
  value = aws_security_group.web.id
}
output "mysql_secgroup_id" {
  value = aws_security_group.mysql.id
}
output "database_subnet_group_name" {
  value = module.vpc.database_subnet_group_name
}
output "database_subnet_ids" {
  value = module.vpc.database_subnets[0]
}
output "public_subnet_ids" {
  value = module.vpc.public_subnets[0]
}
