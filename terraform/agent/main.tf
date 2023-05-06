provider "aws" {
  region = "ap-southeast-1"
}

module "ec2_instance" {
  source = "../modules/ec2"

  instance_name      = "jenkins-agent"
  ami_id             = "ami-06ac8ae58c3362210"
  instance_type      = "t2.small"
  key_name           = "jenkins-infra"
  subnet_ids         = ["subnet-07b9057320054ee22", "subnet-0174fcc4415e4ca39", "subnet-0f1c1a6c2e947b004"]
  instance_count     = 1
}