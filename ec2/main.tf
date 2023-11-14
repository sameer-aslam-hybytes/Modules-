resource "aws_key_pair" "terraform-ec2-key" {
  key_name   = "terraform-ec2-key"
  public_key = file("/home/sameer/.ssh/id_rsa.pub")
}

locals {
   staging_env = "staging"
}


resource "aws_instance" "terraform_instance" {
  instance_type = var.instance_type
  ami           = var.ami_id
  key_name      = "${aws_key_pair.terraform-ec2-key.key_name}"

  tags = {
    Name = "${local.staging_env}-ec2-tag"
  }
}

resource "aws_vpc" "staging-vpc"{
    cidr_block = "10.0.0.0/16"

    tags ={
        Name= "${local.staging_env}-vpc-tag" 
    }

}