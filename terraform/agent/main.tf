#Configure Terraform backend on AWS S3
terraform {
  backend "s3" {
    bucket         = "terraform-series-s3-backend-holden"
    key            = "jenkins-setup-agent"
    region         = "ap-southeast-1"
    encrypt        = true
    role_arn       = "arn:aws:iam::767493108029:role/Terraform-SeriesS3BackendRole"
    dynamodb_table = "terraform-series-s3-backend"
  }
}

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