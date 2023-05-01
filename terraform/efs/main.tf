#Configure Terraform backend on AWS S3
terraform {
  backend "s3" {
    bucket         = "terraform-series-s3-backend-holden"
    key            = "jenkins-setup-efs"
    region         = "ap-southeast-1"
    encrypt        = true
    role_arn       = "arn:aws:iam::767493108029:role/Terraform-SeriesS3BackendRole"
    dynamodb_table = "terraform-series-s3-backend"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "efs_module" {
  source     = "../modules/efs"
  vpc_id     = "vpc-0c64f388611289f06"
  subnet_ids = ["subnet-07b9057320054ee22", "subnet-0174fcc4415e4ca39", "subnet-0f1c1a6c2e947b004"]
}