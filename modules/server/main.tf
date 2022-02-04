#Search the AMI list for Ubuntu 20.04 Server
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"] #Filter by Ubuntu 20.04 Server
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical (Creators of Ubuntu)
}

#Create an AWS EC2 Keypair with your public SSH key.
resource "aws_key_pair" "ec2_keypair" {
  key_name   = "ec2-keypair"
  public_key = var.ec2_keypair
}

#Create a network interface for the EC2 Instance
resource "aws_network_interface" "eth0" {
  subnet_id       = var.subnet_id
  security_groups = [var.web_secgroup_id]
}

#Create the EC2 Instance
resource "aws_instance" "web" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  key_name             = "ec2-keypair"
  user_data_base64     = base64encode(local.userDataScript)
  iam_instance_profile = var.aws_iam_instance_profile
  network_interface {
    network_interface_id = aws_network_interface.eth0.id
    device_index         = 0
  }
  tags = {
    "terraform:stackid" = var.tag_terraform-stackid
  }
}

#Elastic IP Address for EC2 Instance
resource "aws_eip" "web" {
  instance = aws_instance.web.id
  vpc      = true
}
