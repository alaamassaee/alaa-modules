terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
  backend "s3" {
    bucket = "alaa-massaee123"
    key    = "terraform_state/s3"
    region = "us-east-1"
  }
}

module "vpc" {
  source               = "../child-module/vpc_and_subnet-module"
  vpc_cider_block      = "10.0.0.0/16"
  subnet_1_cider_block = "10.0.0.0/24"

}
module "sg-module" {
  source = "../child-module/sg-module"
  vpc_id = module.vpc.vpc_id
}
module "ec2-module" {
  source                 = "../child-module/ec2-module"
  image_id               = "ami-03a6eaae9938c858c"
  ec2_type               = "t2.micro"
  vpc_security_group_ids = module.sg-module.sg_id
  subnet_id              = module.vpc.subnet_id

}
output "vpc_id" {
  description = "ID of project VPC"
  value       = module.vpc.vpc_id
}
output "subnet_id" {
  description = "ID of project SUBNET"
  value       = module.vpc.subnet_id
}
output "sg_id" {
  value = module.sg-module.sg_id
}
