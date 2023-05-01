#### Packer HCL2 syntax in file *.pkr.hcl

[**Ansible Provisioner**](https://developer.hashicorp.com/packer/plugins/provisioners/ansible/ansible) 

`extra_arguments` ([]string) - specify additional arguments to be passed to the Ansible command, useful for passing in variables, flags, or other options.

[**ansible arguments**](https://docs.ansible.com/ansible/latest/cli/ansible.html)
`--scp-extra-args SCP_EXTRA_ARGS` - specify extra arguments to pass to scp only
`--scp-extra-args -0` - enable the use of the OpenSSH "packet mode". This mode is more efficient than the default mode, and it can be used to transfer files over slow or unreliable connections.
>single-quote charactor is necessary to pass `-0` as an argument. Without `' '`, it will assume `-0` as a command option.
>```
>--scp-extra-args -0 
>--scp-extra-args '-0'
>```
>in this case, both -0 and '-0' are valid syntaxes


`--ssh-extra-args -o IdentitiesOnly=yes -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedAlgorithms=+ssh-rsa` - Openssh >= 8.8 has ssh-rsa signature algorithm disabled by default. Use these ssh argument to fix this on the packer side. [Read more](https://github.com/hashicorp/packer-plugin-ansible/issues/140)