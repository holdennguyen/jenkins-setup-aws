provider "aws" {
  region = "ap-southeast-1"
}

module "jenkins_iam" {
  source                = "../modules/iam"
  instance_profile_name = "jenkins-instance-profile"
  iam_policy_name       = "jenkins-iam-policy"
  role_name             = "jenkins-role"
}