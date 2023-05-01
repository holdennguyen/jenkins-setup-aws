variable "ami_id" {
    type = string
    default = "ami-082b1f4237bd816a1"
}

variable "efs_mount_point" {
    type = string
    default = ""
}

locals {
    app_name = "jenkins-controller"
}

source "amazon-ebs" "jenkins-controller" {
    ami_name = local.app_name
    instance_type = "t2.micro"
    region = "ap-southeast-1"
    availability_zone = "ap-southeast-1a"
    source_ami = var.ami_id
    ssh_username = "ubuntu"
    tags = {
        Env = "dev"
        Name = local.app_name
    }
}

build {
    sources = ["source.amazon-ebs.jenkins-controller"]

    provisioner "ansible" {
        playbook_file = "ansible/jenkins-controller.yaml"
        extra_arguments = [ 
            "--extra-vars", "ami_id=${var.ami_id} efs_mount_point=${var.efs_mount_point}", 
            "--scp-extra-args", "'-O'", 
            "--ssh-extra-args", "-o IdentitiesOnly=yes -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedAlgorithms=+ssh-rsa" 
            ]
    }

    post-processor "manifest" {
        output = "manifest.json"
        strip_path = true
    }
}