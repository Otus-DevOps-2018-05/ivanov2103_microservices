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

- Создали manifest-ы для запуска наших приложений в объектах типа *Deployment*.  
- В GCP развернули кластер Kubernetes по руководству от Kelsey Hightower: [https://github.com/kelseyhightower/kubernetes-the-hard-way](https://github.com/kelseyhightower/kubernetes-the-hard-way). Проверил запуск подов (ui, post, mongo, comment) командой **for file in $(find ../reddit -type f); do kubectl apply -f $file; done** - поды были созданы и запущены (статус Running)  

### Installing the Client Tools
- Установили клиентские утилиты для создания и управления сертификатами: *fssl*, *cfssljson*, и CLI утилиту для управления кластером: *kubectl*.  
### **\*** Provisioning Compute Resources
- Создание всех инфраструктурных объектов в GCP описано в terraform, в трех модулях: vpc - ресурсы сети, controller - инстансы контроллеров, worker - инстансы воркеров.  
### **\*** Provisioning the CA and Generating TLS Certificates
- Для создания PKI инфраструктуры (корневой сертификат, клиентские и серверные сертификаты компонентов Kubernetes) сделан скрипт *the\_hard\_way/gen\_cert.sh*, который выполняется плейбуком **playbook/pre\_local.yml** на локальном хосте, в подкаталоге *the\_hard\_way*.  
- Копирование ключей и сертификатов на сервера перенесено в таски *base.yml* ролей Ansible: *controller* и *worker*.  
### **\*** Generating Kubernetes Configuration Files for Authentication
- Конфигурационные файлы компонентов Kubernetes для аутентификации и указания на API Servers, генерируются скриптом *the\_hard\_way/gen\_cnf.sh*, который выполняется плейбуком **playbook/pre\_local.yml** на локальном хосте, в подкаталоге *the\_hard\_way*.  
- Копирование файлов на сервера перенесено в таски *base.yml* ролей Ansible: *controller* и *worker*.  
### **\*** Generating the Data Encryption Config and Key
- Создание ключа и конфигурации шифрования секретов Kubernetes перенесено в скрипт *the\_hard\_way/gen\_cert.sh*, копирование конфигурации - в таск *base.yml* роли *controller*.  
### **\*** Bootstrapping the etcd Cluster && Bootstrapping the Kubernetes Control Plane
- Для установки и запуска компонентов контроллеров создана роль *controller* в Ansible.  
- Разворачивание Google Network Load Balancer перенесено в terraform.  
- Структура роли:
  - *files/install\_components.sh* - подготовка файловой структуры контроллеров, скачивание бинарников: etcd, kube-apiserver, kube-controller-manager, kube-scheduler, kubectl, копирование в подготовленные каталоги.  
  - *handlers/main.yml* - обработчики запуска компонентов как сервисов, описанных в конфигурациях systemd, реверс-прокси nginx.  
  - *templates/[etcd.service.j2, kube-apiserver.service.j2, kube-controller-manager.service.j2, kubernetes.default.svc.cluster.local.j2, kube-scheduler.service.j2, kube-scheduler.yaml.j2, rback\_cluster\_role\_to\_user.yaml.j2, rback\_cluster\_role.yaml.j2]* - шаблоны конфигураций компонентов Kubernetes, конфигураций systemd для данных компонентов, конфигурации реверс-прокси nginx для получения health checks API Servers, конфигурации RBAC роли и добавления пользователя в RBAC роль.  
  - *tasks/*
      - *base.yml* - выполнение *install\_components.sh*, копирование сертификатов, конфигураций, вызов обработчиков запуска компонентов контроллеров.  
      - *nginx.yml* - установка nginx, копирование конфигурационного файла, запуск сервиса.  
      - *rback.yml* - копирование и применение конфигураций RBACK.  
      - *main.yml* - включает все таски в необходимой последовательности, определяет условие выполнения rback.yml (только на controller-0).  
### **\*** Bootstrapping the Kubernetes Worker Nodes
- Для установки и запуска компонентов воркеров создана роль *worker* в Ansible.  
- Структура роли:
  - *files/*
      - *get\_pod\_cidr.sh* - скрипт получения адреса подсети. Вынесено в скрипт по причине возникновения ошибки синтаксиса (символ двоеточия в команде) при выполнении модулем shell - быстро не разобрался, не стал тартить время.  
      - *install_worker_component.sh* - подготовка файловой структуры контроллеров, скачивание бинарников: containerd, kube-proxy, kubelet, kubectl и др., копирование в подготовленные каталоги.
  - *handlers/main.yml* - обработчики запуска компонентов как сервисов, описанных в конфигурациях systemd.  
  - *templates/[10-bridge.conf.j2, 99-loopback.conf.j2, config.toml.j2, containerd.service.j2, kubelet-config.yaml.j2, kubelet.service.j2, kube-proxy-config.yaml.j2, kube-proxy.service.j2]* - шаблоны конфигураций компонентов Kubernetes, конфигураций systemd для данных компонентов, конфигураций сетевого плагина CNI.  
  - *tasks/*
      - *base.yml* - выполнение files/* скриптов, копирование сертификатов, конфигураций, вызов обработчиков запуска компонентов контроллеров.  
      - *main.yml* - включает все таски в необходимой последовательности.  
### **\*** Configuring kubectl for Remote Access
- Для создания конфигурационного файла kubectl с предоставлением административных полномочий, сделан скрипт *gen\_cnf\_kubectl.sh*, который выполняется плейбуком **playbook/post\_local.yml** на локальном хосте, в подкаталоге *the\_hard\_way*.  
### **\*** Provisioning Pod Network Routes
- Настройка роутов перенесена в terraform.  
### **\*** Deploying the DNS Cluster Add-on
- Запуск add-on DNS выполняется плейбуком **playbook/dns.yml**.  

Для выполнение модулей Ansible на хостах и сбора фактов, на всех инстансах был установлен python, выполняется плейбуком **playbook/base.yml**.  

Роли Ansible не были оптимизированы для переиспользования - таски и обработчики можно разделить, часть переменных вынести в переменные роли. Docker образы в подах разворачиваются из Docker HUB, были запушены при выполнении предыдущих ДЗ.  
