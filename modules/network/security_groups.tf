#Create a Security Group for the ghost web server and resources
resource "aws_security_group" "web" {
  vpc_id = module.vpc.vpc_id
  tags = {
    "terraform:stackid" = var.tag_terraform-stackid
  }
}

# Create a Security Group for the mysql RDS instance
resource "aws_security_group" "mysql" {
  vpc_id = module.vpc.vpc_id
  tags = {
    "terraform:stackid" = var.tag_terraform-stackid
  }
}

#Create a Security Group Rule to allow SSH traffic from your public IP.
resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.your_public_ip}/32"]
  security_group_id = aws_security_group.web.id
}

#Create a Security Group Rule to allow inbound traffic in the RDS instancefrom the web SG.
resource "aws_security_group_rule" "mysql_inbound" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.mysql.id
  source_security_group_id = aws_security_group.web.id
}

#Create a Security Group Rule to allow outbound traffic in the RDS instance to the web SG.
resource "aws_security_group_rule" "mysql_outbound" {
  type                     = "egress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.mysql.id
  source_security_group_id = aws_security_group.web.id
}

#Create a Security Group Rule to allow inbound traffic for your server into port 443.
resource "aws_security_group_rule" "https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}

#Create a Security Group Rule to allow inbound traffic for your server into port 80.
resource "aws_security_group_rule" "http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}

#Create a Security Group Rule to allow all outbound traffic for your server.
resource "aws_security_group_rule" "outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}
