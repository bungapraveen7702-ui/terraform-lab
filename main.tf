 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
}
}
 
provider "aws" {
  region = "ap-southeast-2"
}
 
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
 
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}
 
resource "aws_instance" "jenkins_vm" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
 
  tags = {
    Name = "Terraform-Jenkins-VM"
  }
}
 
output "instance_public_ip" {
  value = aws_instance.jenkins_vm.public_ip
}