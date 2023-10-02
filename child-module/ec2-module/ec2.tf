provider "aws" {
  # Configuration options
  region = "us-east-1"
}
resource "aws_instance" "webserver_instance" {
  ami                         = var.image_id
  instance_type               = var.ec2_type
  vpc_security_group_ids      = [var.vpc_security_group_ids]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "web server"
  }
}
variable "vpc_security_group_ids" {
  type = string
}
