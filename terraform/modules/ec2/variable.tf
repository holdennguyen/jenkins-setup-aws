provider "aws" {
  region = "ap-southeast-1"
}

variable "instance_name" {
  type = string
  default = "live-test-instance"
}

variable "ami_id" {
  type = string
  default = "ami-082b1f4237bd816a1"
}

variable "instance_type" {
  type = string
  default = "t2.small"
}

variable "key_name" {
  type = string
  default = "jenkins-infra"
}

variable "security_group_ids" {
  type    = list(string)
  default = ["sg-0a30359e97db08404"]
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-07b9057320054ee22", "subnet-0174fcc4415e4ca39", "subnet-0f1c1a6c2e947b004"]
}