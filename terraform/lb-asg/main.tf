#Configure Terraform backend on AWS S3
terraform {
  backend "s3" {
    bucket         = "terraform-series-s3-backend-holden"
    key            = "jenkins-setup-lb-asg"
    region         = "ap-southeast-1"
    encrypt        = true
    role_arn       = "arn:aws:iam::767493108029:role/Terraform-SeriesS3BackendRole"
    dynamodb_table = "terraform-series-s3-backend"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "lb-asg" {
  source        = "../modules/lb-asg"
  subnets       = ["subnet-07b9057320054ee22", "subnet-0174fcc4415e4ca39", "subnet-0f1c1a6c2e947b004"]
  ami_id        = "ami-0ac2a008f2dd604cd"
  instance_type = "t2.small"
  key_name      = "jenkins-infra"
  environment   = "dev"
  vpc_id        = "vpc-0c64f388611289f06"
}