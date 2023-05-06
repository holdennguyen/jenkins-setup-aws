variable "ami_id" {
    type = string
    default = "ami-082b1f4237bd816a1"
}

variable "public_key_path" {
    type = string
    default = "/devops-tools/jenkins/id_rsa.pub"
}

locals {
    app_name = "jenkins-agent"
}

source "amazon-ebs" "jenkins-agent" {
    ami_name = local.app_name
    instance_type = "t2.micro"
    region = "ap-southeast-1"
    availability_zone = "ap-southeast-1a"
    source_ami = var.ami_id
    ssh_username = "jenkins"
    iam_instance_profile = "jenkins-instance-profile"
    tags = {
        Env = "dev"
        Name = local.app_name
    }
}

build {
    sources = ["source.amazon-ebs.jenkins-agent"]

    provisioner "ansible" {
        playbook_file = "ansible/jenkins-agent.yaml"
        extra_arguments = [ 
                "--extra-vars", "public_key_path=${var.public_key_path}",  
                "--scp-extra-args", "'-O'", 
                "--ssh-extra-args", "-o IdentitiesOnly=yes -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedAlgorithms=+ssh-rsa" 
        ]
    } 
  
  post-processor "manifest" {
    output = "manifest.json"
    strip_path = true
  }
}