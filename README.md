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

[https://github.com/Otus-DevOps-2018-02/ivanov2103_microservices/blob/docker-4/README.md](https://github.com/Otus-DevOps-2018-02/ivanov2103_microservices/blob/docker-4/README.md)

## Homework gitlab-ci-1  

[https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/gitlab-ci-1/README.md](https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/gitlab-ci-1/README.md)

## Homework gitlab-ci-2  

[https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/gitlab-ci-2/README.md](https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/gitlab-ci-2/README.md)

## Homework monitoring-1  

[https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/monitoring-1/README.md](https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/monitoring-1/README.md)

## Homework monitoring-2

[https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/monitoring-2/README.md](https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/monitoring-2/README.md)

## Homework logging-1

[https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/logging-1/README.md](https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/logging-1/README.md)

## Homework kubernetes-1

[https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/kubernetes-1/README.md](https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/kubernetes-1/README.md)

## Homework kubernetes-2

[https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/kubernetes-2/README.md](https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/kubernetes-2/README.md)

## Homework kubernetes-3

- Подробно повторили материал по: сетевому взаимодействию между подами с помощью объектов типа Service; дополнений разрешения имен (kube-dns) и создания overlay-сетей; способам взаимодействия.  
- Создали LoadBalancer в качестве единой точки входа в наше приложение, проверили доступ по IP балансировщика. Тип LoadBalancer позволяет управлять трафиком на транспортном уровне, может быть реализован только в облачных сервисах. 
- Более расширенный функционал предоставляют объекты типа Ingress, которые в качестве балансировщиков используют полноценные решения управления трафиком на прикладном уровне (nginx, haproxy и т.п.).  
    - Включили Ingress Controller, описали сервис типа Ingress с правилами простой балансировки (наподобие LoadBalancer) на сервисы типа NodePort. Удалили LoadBalancer.  
    - Настроили Ingress на перенапраление в соответствии с локацией ресурса.  
    - Добавили SSL-терминацию в правила Ingress.
- Для ограничения сетевого доступа создали описание объекта типа NetworkPolicy, предварительно заменив сетевой плагин GKE kubenet на Calico, поддерживающий политики доступа.  
Разрешили доступ к mongoDB только сервисам post и comment.  
- Вместо Volume типа emptyDir, который удаляется с остановкой пода, подключили к mongoDB внешнее GCE хранилище типа gcePersistentDisk. В этом случае данные не удаляются, поду выделяется диск целиком.  
- Механизм PersistentVolume позволяют использовать хранилище, общее для всего кластера, выделяя его подам по запросу.  
Создали описание для PersistentVolume, добавили объект в кластер, создали запрос (PersistentVolumeClaim) на выделение тома, подключили том к поду mongoDB.  
- Для автоматического создания хранилища по запросу, создали объект типа StorageClass, создали новый запрос PersistentVolumeClaim со ссылкой на StorageClass, вместо PersistentVolume, включили данный запрос, вместо предыдущего, в описание пода.  
