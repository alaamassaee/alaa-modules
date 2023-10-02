resource "aws_security_group" "sg-allow-port-80" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg-allow-port-80"
  }
}
variable "vpc_id" {
  type = string
}
output "sg_id" {
  value = aws_security_group.sg-allow-port-80.id
}
