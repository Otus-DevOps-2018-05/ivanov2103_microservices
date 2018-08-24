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

- В GCE был создан инстанс Docker хоста и развернут контейнер с системой мониторинга Prometheus. Познакомился с форматом метрик и описанием целей   Prometheus.  
Был сформирован конфигурационный файл *prometheus.yml* для сбора метрик, определены джобы с адресами (endpoints) размещения метрик и их значений наших микросервисов reddit.  
Образы микросервисов были перестроены скриптами, в конфигурации запуска контейнеров микросервисов удалены директивы предварительной сборки образов, добавлена конфигурация запуска контейнера с Prometheus (*docker-compose.yml*).  
Запустил контейнеры, проверил состояние самих endpoints и состояние микросервисов по их метрикам, значения которых определяются специальными проверками в коде приложения (healthcheck). До и после эмуляции сбоя.  
На примере экспортера метрик Node, изучен способ мониторинга сервисов, не имеющих метрик в формате Prometheus. Запуск контейнера с экспортером добавлен в конфигурацию Docker compose.  

### **\***  

Мониторинг MongoDB был настроен с помощью экспортера percona/mongodb_exporter: [https://github.com/percona/mongodb_exporter](https://github.com/percona/mongodb_exporter), готовый Dockerfile подсмотрел у xendera: [https://github.com/xendera/docker-mongodb-exporter/blob/master/Dockerfile](https://github.com/xendera/docker-mongodb-exporter/blob/master/Dockerfile).  

При настройки мониторинга сервисов comment, post и ui с помощью blackbox экспортера столкнулся с ошибкой недоступности сервисов в сети:  

*Get http://localhost:9115/probe?module=http_2xx&target=ui%3A9292: dial tcp 127.0.0.1:9115: getsockopt: connection refused*  

При этом (проверял внутри контейнера blackbox_exporter)  проходит **telnet ui 9292** и **curl http://ui:9292** страничку возвращает, с localhost - аналогично. Для проверки пришлось собрать образ с более-менее полноценной ОС (закомментировано в Dockerfile).  
Потратил на решение некоторое время безрезультатно, решил попробовать настроить мониторинг с помощью Cloudprober ([https://cloudprober.org/getting-started/](https://cloudprober.org/getting-started/)). Здесь все прошло успешно, получил в своей конфигурации четыре метрики и их состояния для каждого сервиса.

С Makefile особых трудностей не возникло, сделал необходимый минимум. Учетные данные Docker Hub и путь к репозиторию определены переменными окружения в отдельном файле, который был добавлен в *.gitignore* (пример в файле *.make_env.example*).  

Все созданные образы были запушены в Docker Hub.  
