# ivanov2103_microservices
ivanov2103 microservices repository
![Build Status](https://api.travis-ci.org/Otus-DevOps-2018-02/ivanov2103_microservices.png)  

## Homework-04

## Homework-05

## Homework-06

## Homework-07

## Homework-08

## Homework-09

## Homework-11  

## Homework-12  

## Homework-13  

## Homework-14  

## Homework-15  

README.md all Homeworks before that accees by URL below. After Homework-16 each Homework will have own README.md

[https://github.com/Otus-DevOps-2018-02/ivanov2103_microservices/blob/docker-3/README.md](https://github.com/Otus-DevOps-2018-02/ivanov2103_microservices/blob/docker-3/README.md "README.md")

## Homework-16  

[https://github.com/Otus-DevOps-2018-02/ivanov2103_microservices/blob/docker-4/README.md](https://github.com/Otus-DevOps-2018-02/ivanov2103_microservices/blob/docker-4/README.md)

## Homework-17  
- Created GCP instance for Gitlab CI by gcloud command:

**gcloud compute firewall-rules create allow-http-some-host --description "allow http to gitlab-host" --allow tcp:80 --source-ranges="0.0.0.0/0" --target-tags="http-server"**  

**gcloud compute firewall-rules create allow-https-some-host --description "allow https to gitlab-host" --allow tcp:443 --source-ranges="0.0.0.0/0" --target-tags="https-server"**  

**gcloud compute firewall-rules create allow-gitlab-host --description "allow docker to gitlab-host" --allow tcp:2376 --source-ranges="0.0.0.0/0" --target-tags="my-gitlab-host"**  

**gcloud compute instances create gitlab-host --boot-disk-size=50GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=n1-standard-1 --zone europe-west1-b --tags="my-gitlab-host,http-server,https-server" --restart-on-failure**  

and installed docker:  

**export INSTANCE\_EXT\_IP=\`gcloud --format="value(networkInterfaces[0].accessConfigs[0].natIP)" compute instances list --filter="name=( gitlab-host )"\`**  

**docker-machine create --driver generic --generic-ip-address=${INSTANCE_EXT_IP} --generic-ssh-user=appuser --generic-ssh-key ~/.ssh/appuser docker-vm**

docker-compose was needed installed separately:

**ssh appuser@${INSTANCE\_EXT\_IP} sudo apt-get install -y docker-compose**

Created Gitlab CI image and launched container.
Created Group, Project and Pipeline by instructions. Registered Runner and run Pipeline.
Added reddit application to repository and testing him in pipeline.

### **\***  

Ansible was used for automation create Gitlab CI Runners. Registration token take from ansible-vault encryption variables file. Registration command was finded by url: [https://docs.gitlab.com/runner/register/](https://docs.gitlab.com/runner/register/)
Command options of *docker_container* module in my configuration wasn't work (left commented in my playbook) and I used raw module.

My channel with notifications in SLACK:
[https://devops-team-otus.slack.com/messages/C9M5X748Y/](https://devops-team-otus.slack.com/messages/C9M5X748Y/)

Geted error from Gitlab CE pipeline build job:  
*"fatal: repository 'http://gitlab-ci-token:xxxxxxxxxxxxxxxxxxxx@35.205.167.168/homework/example.git/' not found"*  
Recreated Gitlab CI Docker image and container with hostname instead IP. Added resolving hostname to current IP in /etc/hosts on server and my workspace.

