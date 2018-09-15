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

- Обновили код микросервисов, пересобрали docker образы с этими микросервисами, в файле .env заменили теги контейнеров микросервисов на *logging*.
- Подготовили отдельный compose-файл для запуска контейнеров стека EFK системы централизованного логирования:  
 - Fluentd (агрегация, преобразование, отправка лог-сообщений).  
 - ElasticSearch (TSDB и поисковый движок для хранения данных).  
 - Kibana (визуализация логов).   
- Docker образ Fluentd подготовили свой, с нужными плагинами и конфигурационным файлом (*fluent.conf*).
- Рассмотрели структуированные логи на примере сервиса post, увидели, что логи сервис пишет в JSON формате, который поддерживается нашей системой логирования.    
- Заменили стандартный (по умолчанию) драйвер логирования контейнера микросервиса post на *fluentd*.  
- Запустили контейнеры системы логирования, пересоздали контейнеры микросервисов приложения Reddit, познакомились с инструментарием визуализации в Kibana.  
- Для парсинга JSON логов сервиса post добавили фильтр. Фильтр позволяет выделить из лога необходимую информацию и сопоставить ее полям, расширяя возможности поиска данной информации.  
- Обработку неструктурированных логов рассмотрели на примере сервиса ui. Заменили драйвер логирования контейнера микросервиса ui на *fluentd*.  
- Для парсинга логов использовали сначала собственные регулярные выражения, а, затем, готовые grok-шаблоны регулярных выражений.  
  
### **\***  

- Оставшийся неразобранным, лог был разобран с помощью дополнительного фильтра по аналогии с предыдущим. Использовал базовые шаблоны, список которых нашел здесь: [https://github.com/jordansissel/grok/blob/master/patterns/base](https://github.com/jordansissel/grok/blob/master/patterns/base)

#### Homework logging-1 - продолжение.

- Развернули контейнер с сервисом распределенного трейсинга Zipkin, пересоздали контейнеры с микросервисами Reddit, разобрали трейсы наших запросов в Zipkin WEB UI.  

### **\****  

- Bugged микросервисы распаковал в отдельный подкаталог, ./src/bugged.  
Отредактировал docker\_build.sh всех сервисов bugged, добавил тег *logging* к создаваемым образам, чтобы не менять теги для контейнеров в файле .env.
После запуска в UI (http://UI\_IP:9292) увидел ошибку:  
*Can't show blog posts, some problems with the post service. Refresh?*  
Посмотрел логи в Kibana, увидел ошибку (пример при попытке открытия поста):  
*Failed to read from Post service. Reason: Failed to open TCP connection to 127.0.0.1:4567 (Connection refused - connect(2) for "127.0.0.1" port 4567)*  
Похоже, не определены параметры коннекта. Проверил Dockerfile - действительно, переменные окружения *POST\_DATABASE\_HOST* и *POST\_DATABASE* не определены, исправил, проверил Dockerfile остальных сервисов, обнаружил аналогичную ситуацию, то же, исправил.  
После исправления и запуска посты стали открываться, но с задержкой, как и было оговорено в задаче. Посмотрел трейсы, нашел, что обработка запроса сервисом пост заняла более 3 секунд (операция db\_find\_single\_post):  
*post.db\_find\_single\_post: 3.006s*  
Нашел вызов метода time.sleep(3) в функции поиска поста. Закомментировал, пересобрал образы, пересоздал контейнеры с сервисами - посты стали открываться без задержек.  
