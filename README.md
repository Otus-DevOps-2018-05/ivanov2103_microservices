# ivanov2103_infra
ivanov2103 Infra repository
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
- Viewed how working network drivers: *none*, *host*.  
Question (driver *host*): "Каков результат? Что выдал docker ps? Как думаете почему?"  
Answer: "Запустился только один контейнер, потому что несколько сервисов с одним и тем же портом не могут быть запущены."  
### **\***  
Containers with driver *host* work in host network namespace, host *default* network namespace used by this containers.  
  
**docker ps | grep -v "CONTAINER ID" ; echo "===namespaces===" ; ip netns**  
*===namespaces===  
default*  
**docker run --network host -d nginx**  
*dc3f3b9580f80f91f7b16504a769d3b59003adad64e3552313bc8c88e662ff6b*  
**docker ps | grep -v "CONTAINER ID" ; echo "===namespaces===" ; ip netns**  
*dc3f3b9580f8        nginx               "nginx -g 'daemon of…"   3 seconds ago       Up 3 seconds                            confident_morse  
===namespaces===  
default*

Container with driver *none* working in dedicated network namespace with localhost interface only.  
  
**docker run --network none -d nginx**  
*d496df048c14c7f3f460a4e723bbcb3204371a7f0a7f69c260957661a4da188c*  
**docker ps | grep -v "CONTAINER ID" ; echo "===namespaces===" ; ip netns**  
*d496df048c14        nginx               "nginx -g 'daemon of…"   5 seconds ago       Up 4 seconds                            competent_bhabha  
dc3f3b9580f8        nginx               "nginx -g 'daemon of…"   3 minutes ago       Up 3 minutes                            confident_morse  
===namespaces===  
2cb70fb43f1c  
default*  
**ip netns exec 2cb70fb43f1c ip -s link**  
*1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000  
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00  
    RX: bytes  packets  errors  dropped overrun mcast  
    0          0        0       0       0       0  
    TX: bytes  packets  errors  dropped carrier collsns  
    0          0        0       0       0       0*
    
- Viewed how working network driver *bridge*.  
Launched containers in one separate bridge networks with *--network-alias* for name resolution.  
Launched containers in several dedicated bridge networks with *--name* for name resolution and connected "post" and "comment" containers to bridge "ui" container.  
### **\***  
Bridge networks docker host and bridge interfaces of containers was viewed.  
Viewed iptables rules for containers access to external network (MASQUERADE source address translation for all bridge networks), DNAT rule for translation all input connections on 9292 port to "ui" container.  
For listeting 9292 port running docker-proxy process.  

- Installed docker-compose, created *docker-compose.yml* declaration and *.env* file with some enviroment variables for docker-compose.  
Adapted docker-compose.yml for launching containers in several dedicated bridge networks.  
### **\***  

Default project name may be change by *"-p"* command option, by the *"COMPOSE\_PROJECT\_NAME"* environment and *"project_name"* instruction in .yml file.  
### **\***  

I wasn't found how coping files to container by docker-compose and was used volumes instruction for mount directory with app code to container: 
[https://stackoverflow.com/questions/42877801/how-to-sync-code-between-container-and-host-using-docker-compose](https://stackoverflow.com/questions/42877801/how-to-sync-code-between-container-and-host-using-docker-compose)  
[https://docs.docker.com/compose/extends/#understand-the-extends-configuration](https://docs.docker.com/compose/extends/#understand-the-extends-configuration)  

Src files was copied to docker-host by rsync:  
**rsync -avzh ~/ivanov2103_microservices/src/ui ~/ivanov2103_microservices/src/comment ~/ivanov2103_microservices/src/post-py appuser@docker-host:/home/appuser/src**  

Checking volumes:  
**docker exec comment ls -l /app/TestFile ; ssh appuser@35.195.242.58 touch /home/appuser/src/comment/TestFile; docker exec comment ls -l /app/TestFile**  
*ls: /app/TestFile: No such file or directory  
Warning: Permanently added '35.195.242.58' (ECDSA) to the list of known hosts.  
-rw-rw-r--    1 1002     1003             0 Jun 23 07:12 /app/TestFile*  

Checking debug and number of workers (finded in log):  
**docker logs -f comment**  
*...  
[1] \* Process workers: 2  
...  
D, [2018-06-23T07:03:27.748739 #8] DEBUG -- : MONGODB | Server comment_db:27017 initializing.*  