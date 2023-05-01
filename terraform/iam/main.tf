#Configure Terraform backend on AWS S3
terraform {
  backend "s3" {
    bucket         = "terraform-series-s3-backend-holden"
    key            = "jenkins-setup-iam-role"
    region         = "ap-southeast-1"
    encrypt        = true
    role_arn       = "arn:aws:iam::767493108029:role/Terraform-SeriesS3BackendRole"
    dynamodb_table = "terraform-series-s3-backend"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "jenkins_iam" {
  source                = "../modules/iam"
  instance_profile_name = "jenkins-instance-profile"
  iam_policy_name       = "jenkins-iam-policy"
  role_name             = "jenkins-role"
}