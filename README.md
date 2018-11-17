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

- Были установлены утилиты kubectl и minikube. Бинарник kubectl скачивл по ссылке: [http://storage.googleapis.com/kubernetes-release/release/v1.10.0/bin/windows/amd64/kubectl.exe](http://storage.googleapis.com/kubernetes-release/release/v1.10.0/bin/windows/amd64/kubectl.exe), так как в Powershell Gallery последняя версия 1.6 от 29.10.2017, а нам требуется не меньше 1.8.0.  
- Minukube-кластер был развернут и запущен в локальном гипервизоре VirtualBox.  
Познакомился с описанием манифеста и конфигурированием kubectl.  
- Запустили UI, в описание добавили метки пода, указали их селектору, определили прослушиваемый приложением порт, пробросили при помощи kubectl на локальную машину, убедились в доступности приложения по ссылке http://localhost:local-port.  
Повторили для comment, post и mongoDB. Для mongoDB добавили описание стандартного Volume.  
- Создали по объекту Service для связи ui с post и ui с comment, в описание добавили метки подов на которые перенаправляется трафик. Проверили разрешение в DNS имени сервиса.  
Добавили Service для mongoDB, пробросили порт на под UI, нашли причину недоступности mongoDB (comment и post обращаются к БД по именам, определенным ранее переменными в Dockerfile-ах и отличными от имени нашего сервиса).  
- Разделили сервис mongoDB на два: для БД comment и для БД post, определили новые метки для селектора сервисов, добавили эти метки в манифест пода mongoDB.  
Переопределили подам comment и post переменные окружения для обращения к базам, установили их в соответсвие именам новых сервисов.  
Пересоздали объекты, убедились в доступности БД сервисам comment и post.  
- Для доступа к UI снаружи определили сервис типа NodePort. С помощью minicube получили страницу с адресом ноды и портом, открытым для перенаправления трафика на targetPort пода. Увидели, так же, назначенный порт ноды в выводе команды **minikube services list**.  
- Посмотрели список запущенных add-on-ов minicube, нашли объекты dashboard в namespace kube-system, познакомились с визуализированным представлением кластера.  
- Выделили namespace dev для среды разработки, запустили приложение в выделенном окружении, добавили в манифест UI информацию об окружении.  
- Развернули Kubernetes cluster в Google Kubernetes Engine GCP, сгенерировали новый контекст kubectl для подключения к GKE, создали dev namespace, задеплоили все компоненты приложения в namespace dev.  
Создали правило файерволла для доступа к нодам кластера по портам из диапазона: 30000-32767, нашли порт публикации сервиса UI, проверили доступность приложения  
Запустили dashboard в GKE, обнаружили отсутствие необходимых привилегий у dashboard. Назначили нашему Service Account роль cluster-admin для полного доступа к кластеру, убедились, что dashboard открывается без ошибок.  

## **\***

На звездочку, к сожаление, времени не остается, на работе начали внедрять практики DevOps, занимаюсь этим и в нерабочее время.  

P.S.
В следующем ДЗ столкнулся с необходимостью пересоздания кластера - сделал звездочку в части разворачивания кластера GKE terraform-ом.  
