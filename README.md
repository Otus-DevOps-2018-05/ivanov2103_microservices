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

Мои образы в Docker Hub - [https://hub.docker.com/u/ivanov2103/](https://hub.docker.com/u/ivanov2103/).  
Мой тестовый канал в SLACK - [https://devops-team-otus.slack.com/messages/C9M5X748Y/?](https://devops-team-otus.slack.com/messages/C9M5X748Y/?).  

- Разделили файл конфигурации запуска контейнеров на два: *docker-compose.yml* - оставили только описание приложений, *docker-compose-monitoring.yml* - описание всех контейнеров, связанных с мониторингом.  
- Для мониторинга состояния наших контейнеров развернули cAdvisor в отдельном контейнере, рассмотрели основные метрики: использование ЦПУ, памяти, сети, ФС, запущенные процессы.  
- Для визуализации метрик развернули контейнер с Grafana, настроили отображение метрик cAdvisor: добавили Prometheus в качестве источника данных, импортировали дашборд *"Docker and system monitoring"* с сайта Grafana.  
- Метрики приложений.  
Добавили в Prometheus сервис post нашего приложения Reddit, в Grafana создали дашборды для представления метрик приложений: счетчик HTTP запросов к приложению - *ui\_request\_count* (изменение во времени, рост изменений за промежуток времени, рост изменений ошибочных запросов за промежуток времени), гистограмма  времени обработки HTTP запросов - *ui\_request\_latency\_seconds* (изменение 95-го перцентиля).  
- Метрики бизнес-логики.  
Создали дашборд с графиками роста изменений за час счетчиков количества постов (*post\_count*) и комментариев (*comment\_count*).  
Сохранили шаблоны наших дашбордов в репозиторий.  
- Настроили оповещение о критичных состояниях систем. Для этого развернули еще один контейнер с дополнительным компонентом Prometheus - Alertmanager.  
В конфигурации Alertmanager (*config.yml*) настроили отправку оповещений в личный канал SLACK.
В конфигурации алертинга Prometheus (*alerts.yml*) настроили срабатывание на недоступность любого из endpoint (метрика **up**).  

### **\***  

- Дополнил Makefile созданием и публикацией новых образов.
- Настроил экспериментальный режим Docker на отдачу метрик в формате Prometheus. Сделал все по документации, но столкнулся с проблемой недоступности endpoint. Нашел решение изменением параметра *"metrics-addr"* в значение *"0.0.0.0:9323"*.  
Как я понял, данный режим больше предназначен для сбора метрик Docker swarm (swarm_\*), кроме того, метрик, содержащих ID или имена контейнорв в листинге не нашел **(curl 127.0.0.1:9323/metrics | grep "cloudprober\|43a13362b3f4")**. Импортировал готовый дашборд: *"Docker Engine Metrics"* - 1229.  
- Для сбора системных метрик контейнеров агентом Telegraf и передачи их в InfluxDB, развернул еще два контейнера: с агентом Telegraf, передающим метрики в формате InfluxDB (time series database), и самой БД InfluxDB. В Grafana добавил новый источник данных - InfluxDB.  
Так же, как и в cAdvisor, есть основные системные метрики всех контейнеров.  
Мне понравились дашборды: *"Docker overview"* - 5763 и *"InfluxDB Docker"* - 1150.  
- Анализ счетчиков гистограммы *ui\_request\_latency\_seconds* показал, что  максимальное время ответа сервиса, за период наблюдения, меньше 50мс. Настроил формирование алерта на превышение 95-ым перцентилем порога в 50мс. Для превышения данного порога времени ответа сервиса, зафлудил порт приложения:   
**hping3 -c 100 -d 120 -S -w 64 -p 9292 --flood --rand-source 10.132.0.2**  
Получил сообщение о большом времени ответа приложения в свой канал SLAK.  
- Для получения почтовых нотификаций установил postfix на docker-host (меняется всего один параметр стандартной, одной из предустановленных, конфигурации - посчитал этот способ несложным и не затратным по времени). Не сразу разобрался с настройкой маршрутов для отправки во все ресиверы.     
Сокращенный пример почтовой нотификации:  
*appuser@docker-host:~$ head -n 16 /var/mail/appuser  
From ivanov2103@example.com  Wed Sep  5 17:34:48 2018  
Return-Path: <ivanov2103@example.com>  
X-Original-To: appuser@docker-host  
Delivered-To: appuser@docker-host  
Received: from localhost (unknown [10.0.2.8])  
        by docker-host.c.docker-214615.internal (Postfix) with ESMTP id C81383ED05
        for <appuser@docker-host>; Wed,  5 Sep 2018 17:34:48 +0000 (UTC)  
From: ivanov2103@example.com  
Subject: [FIRING:1] InstanceDown (ui:9292 ui page)  
To: appuser@docker-host  
Date: Wed, 05 Sep 2018 17:34:48 +0000  
Content-Type: multipart/alternative;    boundary=84b3d104f48bdc40f92c7b23d79a75a793d12bda0c0c638511fa24fd088a  
MIME-Version: 1.0
--84b3d104f48bdc40f92c7b23d79a75a793d12bda0c0c638511fa24fd088a  
Content-Type: text/html; charset=UTF-8  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">*  

Описания всех новых контейнеров данного ДЗ добавлены в *docker-compose-monitoring.yml*, сервисы сбора метрик для Prometheus включены в *prometheus.yml*, созданные образы запушены в Docker Hub. При выполнении ДЗ добавляли правила файерволла GCP на открытие портов сервисов по необходимости.  
