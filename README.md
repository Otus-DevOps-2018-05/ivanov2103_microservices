# ivanov2103_infra
ivanov2103 Infra repository
![Build Status](https://api.travis-ci.org/Otus-DevOps-2018-02/ivanov2103_microservices.png)  

## Homework-04
- SSH command for jumping to local someinternalhost across bastion host:  
**$ ssh -J appuser@35.205.23.100 appuser@10.132.0.3**  
- Configuration for use short command of SSH jumping with aliase:  
**$ cat ../.ssh/config**  
_Host bastion  
 HostName 35.205.23.100  
 User appuser  
Host someinternalhost  
 HostName 10.132.0.3  
 User appuser  
 ProxyCommand ssh -A bastion -W %h:%_  
- GCP hosts IP:  
bastion_IP = 35.205.23.100  
someinternalhost_IP = 10.132.0.3  

## Homework-05
- command for create firewall-rules:  
**gcloud compute firewall-rules create default-puma-server \\  
    --network default \\  
    --action allow \\  
    --direction ingress \\  
    --rules tcp:9292 \\  
    --source-ranges 0.0.0.0/0 \\  
    --priority 1000 \\  
    --target-tags puma-server**
- For create VM and firewall-rules run command:  
**./create_VM_firewall.sh**  
- For install Ruby, Mongodb and deploy application, run commands:  
**scp ~/ivanov2103_infra/deploy.sh ~/ivanov2103_infra/install_mongodb.sh ~/ivanov2103_infra/install_ruby.sh appuser@35.195.95.117:\~/**  
**ssh appuser@35.195.95.117 './install_ruby.sh ; ./install_mongodb.sh ; ./deploy.sh'**  
- For create VM and firewall-rules with a startup script local file, run command:  
**./create_VM_firewall_file.sh**  
- For create VM and firewall-rules with a startup script stored on Google Cloud Storage, run command:  
**./create_VM_firewall_url.sh**  
- Test hosts IP:Port:  
testapp_IP = 35.195.95.117  
testapp_port = 9292  

## Homework-06
- For create GCP image by Packer template, including Ruby and MongoDB, run command:  
**./packer build -var-file=variables.json ubuntu16.json**  
- For create GCP image "Full" by Packer template, including Ruby, MongoDB and deployed application with autostart, run command:  
**./packer build -var-file=variables.json immutable.json**  
- For create GCP image "Full" and runing instatnce from this by gcloud command, run:  
**packer build -var-file=variables.json immutable.json ; sleep.exe 15 ; \.\./config-scripts/create-reddit-vm.sh**
- Test hosts IP:Port:  
testapp_IP = 35.195.95.117  
testapp_port = 9292  

## Homework-07
- For create two GCP instances with Ruby, MongoDB and deployed Reddit application, run command: **terraform.exe apply**. The load balancer is also created.  
### **\***  
1. Arguments for add more keys to the metadata resource (google_compute_project_metadata_item):  
_key   = "ssh-keys"  
value = "appuser:${file(var.public_key_path)} appuser1:${file(var.public_key_path)} appuser2:${file(var.public_key_path)}"_  
2. Key "appuser_web" was deleted after executing **terraform apply** because there was no configuration for this resource.  
### **\*\***
1. For creating load balancing  instance, resources was defined from documentation (https://cloud.google.com/compute/docs/load-balancing/http/). Resource configuration based on  "gce-lb-http" module parts (https://registry.terraform.io/modules/GoogleCloudPlatform/lb-http/google/1.0.5).   
2. We are use argument "count" for deploy more than one identical instance.  
- Test hosts IP:Port (load balancer):  
testapp_IP = 35.190.2.190  
testapp_port = 80  

## Homework-08
- Was imported SSH firewall rule resource, has been studied dependence of resources by example of App IP resource creation. The configuration was divided to App and DB modules. Were created: configurations for two infrastructure environments, storage buckets resources from "storage-bucket" registry module.  
### **\***  
Was created remote backend on GCP storage for state file. It was done for App and DB environments. Was verified blocking the state file with simultaneous access (_Error: Error locking state: Error acquiring the state lock: writing "gs://storage-bucket-prod/terraform/state/default.tflock" failed: googleapi: Error 412: Precondition Failed, conditionNotMet_).  
### **\*\***  
Were added App module provisioners for deploying Reddit. For access to Mongodb was needed change the configuration of Mongodb and recreated the image of the DB instance:  
_$ cat ../../packer/scripts/install_mongodb.sh  
\#!/bin/bash  
...  
apt install -y mongodb-org  
**sed -i 's/.\*bindIp:.\*/  bindIp: 0.0.0.0/' /etc/mongod.conf**  
systemctl enable mongod_  

## Homework-09
- Was created configution file, inventory with hostgroups in .ini and .yaml format, studed some modules (ping, command, shell, systemd, service, git). Was implemented simple playbook for install Reddit application.  
### **\***  
Was created inventory in .json format by task recuirements. Was implemented simple script accepting only _--list_ parameter for reading JSON inventory. The _--host_ parameter doesn't was implement because JSON inventory has _\_meta_ element with variables.  
## Homework-10  
- Was studied handlers and templates for configuration and deploying. Were studied different approaches to infrastructure management: one playbook - one play, one playbook - many plays, many playbooks. Was replaced bash scenaries to ansible playboks in packer provisioners and re-created GCE instance images.  
### **\***  
Was created dynamic inventory by gce.py script, file secrets.py with defined parameters  was putted in $PYTHONPATH directory (/usr/lib/python2.7/), file gce.ini with undefined parameters values was putted in ansible work directory. In user ~/.profile was determined environment variable $GCE_INI_PATH with path to gce.ini. GCE service account JSON credentials was taken outside the repository. In ansible.cfg was changed local inventory to dynamic. Was created playbooks for dynamic inventory (filenames with suffix \_di), in this playbooks was changed hosts.  

## Homework-11  
- Was doed:  
Created role for manage db and app services in Galaxy format.  
Created app and db environments with their inventory and group variables.  
Optimized ansible directory and ansible.cfg.  
Used community role jdauphant.nginx for configure nginx reverse-proxy.  
Learned use Ansible Vault for keep password in encrypted files.  
### **\***  
Dynamic inventory from Homework-10 was configured for using in stage and prod environments. Added host groups, returned by dynamic inventory script in hosts and group variables configuration (Thank Andrei Bogomja and Nikolay Antsiferov).  
### **\*\***  
Was configured TravisCI for check syntax and configuration my packer templates, terraform files and ansible files. Created a github separate repository for test TravisCI checks by trytravis util.  
**Build status badge in title README.md.**  

## Homework-12  
- Local infrastructure was deployed with use Vagrant.  
Phyton installing moved to dedicated playbook, added tasks for installing and configuration Mongo DB, installing Ruby and configuration Puma.  
Added parameter for deploy user and changed templates and tasks for use it as variable.  
I use WSL and needed in some additional tuning: added environment variable (https://www.vagrantup.com/docs/other/wsl.html) and changed Vagrantfile - turning off the serial port (https://github.com/joelhandwell/ubuntu_vagrant_boxes/issues/1).  
### **\***  
Wariable nginx_sites format was difined by example from https://www.vagrantup.com/docs/provisioning/ansible_common.html and ansible app task message below from playing on GCP stage environment (deleted after checking).  
\- name: Show nginx_sites variable value  
  debug:  
    msg: "{{ nginx_sites }}"  
- Were installed Molecule, Ansible, Testinfra in python *virtualenv* environment. Changed testinfra version in requirements.txt because received an error:  
*"molecule 2.14.0 has requirement testinfra==1.12.0, but you'll have testinfra 1.14.0 which is incompatible."*   
Were created and running some tests by Testinfra modules for check: MongoDB is enabled and running, has valid bindIp in config and listening TCP port 27017.  
Packer templates was changed for use role.  
For my WSL environment i needed configure Virtualbox provider across provider_raw_config_args variable in molecule.yml:  
platforms:  
  \- name: instance  
    provider_raw_config_args:  
      \- "customize [ 'modifyvm', :id, '--uartmode1', 'disconnected' ]"  
### **\*\***
Moved DB role to other git repository and plugged it to "infra" repository. Checked this by creating terraform stage envinroment and playing site.yml - was succesful.  
Added checking my DB role to TravisCI (used example):https://github.com/ivanov2103/ansible_role_dbserver - build status badge in title README.md.  
Added build notification to my Slack channel \#igor_ivanov.  
In integration process I had some errors:  
*"GoogleAuthError('PyCrypto library required for '\nlibcloud.common.google.GoogleAuthError: 'PyCrypto library required for Service Account Authentication.'\n"}*  
*ERROR: Ansible version '2.3.0.0' not supported.  Molecule only supports Ansible versions '>=2.5' with Python version '(3, 6)'*  
For correcting this errors was changed install instruction in .travis.yml: "- **travis_wait** pip install **ansible>=2.5** molecule apache-libcloud **pycrypto**"  

## Homework-13  
- I was studed create and basic manage containers (run, start/stop/kill, view, delete), running process in to container, creating image from container.  
I saw that changes in the container do not affect the image.  
### **\***  
Commented in docker-monolith/docker-1.log.  

## Homework-14  
- Docler-machine in GCP docker project was installed and some demos from lecture was repeated.  
Container run in host namespace and get access to host processes when executing the command **docker run --rm --pid host -ti tehbilly/htop**  
Builded image with added MongoDB and reddit application and script for running this. Launched container from building image, added GCP VPC firewall rule and checked access to reddit.  
Registered on the Docker Hub and uploaded my image.  
Launched container from building image in my local host and checked access to reddit on my host.  
### **\***  
Created a packer template with ansible provisioner for install Docker.  
Created terraform configurations for deploying instances from this packer template. Number of instances defined by a variable.  
Created ansible playbooks for install Docker and launching container with applications (https://docs.ansible.com/ansible/latest/modules/docker_container_module.html).  
To save time made a simplified configurations from previous homeworks.  
Was checked access reddit by url http://IP_instancess:9292 - passed.  
