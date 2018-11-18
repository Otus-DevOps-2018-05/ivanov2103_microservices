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

На лекции предупреждали, что в ДЗ есть ошибки, оставленные сознательно - постарался все указать здесь.
- Установили Helm. Для установки Tiller создали манифест с описанием сервисного аккаунта для него и присвоения данному аккаунту необходимой роли.  
Инициализировали Tiller в кластере.  
- Подготовили файловую структуру для Chart.  
Создали описание Chart-а компоненты UI, перенсли манифесты UI в templates, установил Chart (нашел синтаксическую ошибку в Chart.yaml).  
    - Шаблонизировали Chart UI. На этом шаге в ДЗ две ссылки на описание, правильная: [https://gist.githubusercontent.com/chromko/9c78dab140a134feed10214838ee2d39/raw/f600ab1fe48d279c257df6643e4ddae318d3c597/gistfile1.txt](https://gist.githubusercontent.com/chromko/9c78dab140a134feed10214838ee2d39/raw/f600ab1fe48d279c257df6643e4ddae318d3c597/gistfile1.txt "service.yaml") - с конкретным, не шаблонизированном, значением port, т.к. используем пока только встроенные переменные, свои еще не вводили. Установили несколько релизов UI.  
    - Кастомизировали установку своими переменными.  
    - Собрали шаблонизированный пакет для компонент Post и Comment с шаблоном для задания адреса БД.  
- Создали хелпер определения в одной переменной имени релиза и чарта, заменили получение имени релиза и чарта в полях name на данный хелпер во всех манифестах всех компонентов. На 36-ом слайде нашел ошибку в имени каталога пути к service.yaml: charts/comment/templates/service.yaml, должно быть: **C**harts/... (с большой буквы).  
- Для управления зависимостями всех компонентов объединили их в чарте reddit, зафиксировали зависимости.  На 44-ом слайде команда **helm dep update** приведена без указания на поддиректорию с Chart.yaml reddit (должно быть **helm dep update ./reddit**, т.к. предполагается, что мы находимся в kubernetes/Charts).  
Добавили в зависимости установки чарт mongoDB из общедоступного репозитория.  
- Установили приложение, все компоненты, определенные в зависимостях. Обнаружили недоступность БД, переопределили переменные окружения параметров соединения c Post и Comment для контейнеров с UI, шаблонизировали с учетом динамического изменения имен Post и Comment.  
- Переопределили переменные зависимых чартов в чарте reddit, обновили зависимости и обновили наш релиз, убедились в доступности всех компонентов приложения.  
- Увеличили вычислительные ресурсы кластера GKE, добавили узел типа n1-standard-2.  
- Скачали чарт Gitlab omnibus, дополнили описание некоторых объектов чарта, установили. Создали группу и проекты в Gitlab.
Подготовили файловую структуру под наш проект, перенесли исходные коды компонентов приложения, чарты, в директории каждого компонента инициализировали локальные репозитории git, запушили в соответствующие репозитории Gitlab.  
- Добавили в репозиторий UI описание CI процесса - Pipeline завершился без ошибок.  
По аналогии добавили описание CI процессов в проекты Post и Comment.  
- Добавили возможность разработчику запускать отдельное
окружение в Kubernetes по коммиту в feature-бранч - в pipeline была добавлена стадия review (для запуска приложения в кластере) с вызовом функции deploy (для загрузки чарта из репозитория reddit-deploy и установки релиза). На слайде 76 ошибка в пути к values.yml, должно быть: reddit-deploy/ui/values.yml.  
Добавили стадию и функцию удаления окружения review.  
Не проходит статдия review, в функции install_dependencies ошибка, неправильный URL на получения ключа sgerrand.rsa.pub. Так же, установленный tiller более свежей версии, в функции install_tiller заменил параметр --upgrade на --force-upgrade в команде инициализации. Нашел исправление в канале курса, спасибо Vasily и Alexander Suleymanov.  
Распространили изменения на Post и Comment.  
- Создали pipeline для деплоя, задеплоили приложение в окружениях staging и production.  

