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

[https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/kubernetes-3/README.md](https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/kubernetes-3/README.md)

## Homework kubernetes-4

[https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/kubernetes-4/README.md](https://github.com/Otus-DevOps-2018-05/ivanov2103_microservices/blob/kubernetes-4/README.md)

## Homework kubernetes-5

### Мониторинг
- Установили ingress-контроллер nginx из Helm-чарта.  
- Загрузили prometheus в Charts каталог, переопределили некоторые переменные в custom_values.yml, установили prometheus.  
Ознакомились с, уже добавленными в мониторинг, таргетами, найденными с помощью service discovery, настроенного через custom_values.yml.  
Для безопасного сбора метрик настроена схема подключения по https, познакомились с настройками relabel_configs.  
- Для сбора информации о состоянии объектов k8s, включили в custom_values.yml сервис kube-state-metrics, обновили релиз.  
Включили сбор метрик node-exporter.  
- Запустили приложение из чарта reddit в трех окружениях.  
- Изменили custom_values.yml, добавили в механизм ServiceDiscovery параметры для обнаружения приложений и метки k8s для них. Дополнительно добавили метки для prometheus.  
Отделили target-ы компонент приложений друг от друга по окружениям и по компонентам приложения.  
- Установили Grafana из Helm-чарта. Команда установки, как выяснилось, должна быть такой:
helm upgrade --install grafana stable/grafana --set "adminPassword=admin" \  
--set "service.type=NodePort" \  
--set "ingress.enabled=true" \  
--set "ingress.hosts={reddit-grafana}" - спасибо Vitaliy Lopin.  
Добавили prometheus data-source и дашборд "Kubernetes cluster monitoring (via Prometheus)".  
Для фильтрации отображаемой информации использовали механизм templating - добавили переменную запроса к prometheus, шаблонизировали запрос. Добавил изменения в дашборды: UI_Service_Monitoring.json и Business_Logic_Monitoring.json.  

### Логирование
- Добавили метку elastichost самой производительной ноде, создали манифесты объектов стека EFK, запустили стек.
Установили Kibana из Helm-чарта, просмотрели информацию о кластере.  
