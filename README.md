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
=======
Для создания сервера на пуш ветки, взял за основу ДЗ №14 и документацию:
[https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu](https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu)
[https://docs.docker.com/install/linux/docker-ce/debian/](https://docs.docker.com/install/linux/docker-ce/debian/)
[https://cloud.google.com/docs/authentication/getting-started](https://cloud.google.com/docs/authentication/getting-started)
[https://cloud.google.com/sdk/docs/authorizing](https://cloud.google.com/sdk/docs/authorizing)
[https://cloud.google.com/sdk/gcloud/reference/auth/activate-service-account](https://cloud.google.com/sdk/gcloud/reference/auth/activate-service-account)  
Для тестирования была создана отдельная ветка, в репозиторий с ДЗ не добавлена. Итоговые файлы из этой ветки после тестов были скопированы за пределы локального репозитория, тестовая ветка удалена, фалы скопированы в ветку gitlab-ci-2. Так было сделано для того, чтобы не тянуть в репозиторий с ДЗ историю тестовых коммитов в большом количестве.  
Выяснил, что docker executors выполняются в среде Debian 8 (image: ruby:2.4.2).  
Решил, что сервер с докер-машиной будет создаваться только один раз, независимо от количества пушей в данной ветке, пока не будет удален.  
В проект *example2 Gitlab CI* были добавлены переменные окружения с key-file GCP и названием проекта:  
*GCP\_AUTH\_KEY  
GOOGLE\_PROJECT*  
В ходе тестирования столкнулся с рядом проблем, для исследования которых запускал отдельный контейнер с Debian 8:  
\- отсутствие привилегий у сервисного аккаунта GCP на выполнение команд **gcloud compute ...** - решено созданием нового аккаунта с ролями: "Администратор Compute" и "Редактор" проекта.  
\- не сразу учел, что каждый джоб запускается в своем, изолированном, окружении, пытался использовать команду **docker-machine rm** для удаления сервера - заменил на **gcloud compute instances delete**.  

Образ с reddit решил сохранять в GitLab Container Registry:  
[https://docs.gitlab.com/ce/administration/container_registry.html#container-registry-domain-configuration](https://docs.gitlab.com/ce/administration/container_registry.html#container-registry-domain-configuration)  
[https://docs.gitlab.com/ee/user/project/container_registry.html#build-and-push-images](https://docs.gitlab.com/ee/user/project/container_registry.html#build-and-push-images)  
[https://about.gitlab.com/2016/05/23/gitlab-container-registry/](https://about.gitlab.com/2016/05/23/gitlab-container-registry/)  
Для включения Registry был сгенерирован самоподписной сертификат, который в сборочном окружении добавлялся в список доверенных (иначе не работает команда **docker login**).  
Сначала для сборочного окружения брал образ docker:dind, но возникли проблемы с разрешением имен (ниже), потратил некоторое время, не разобрался, оставил до лучших времен. Взял за основу тот же Debian 8. Пожалуй, стоит оставить на память о проблеме с привилегиями: [https://gitlab.com/gitlab-org/gitlab-runner/issues/1544](https://gitlab.com/gitlab-org/gitlab-runner/issues/1544).    
**$ echo "$GITLAB_HOST	gitlab-host.my" >> /etc/hosts**  
**$ cat /etc/hosts**  
*127.0.0.1	localhost  
::1	localhost ip6-localhost ip6-loopback  
fe00::0	ip6-localnet  
ff00::0	ip6-mcastprefix  
ff02::1	ip6-allnodes  
ff02::2	ip6-allrouters  
172.17.0.4	docker 67049a353076 runner-ba2ea204-project-4-concurrent-0-docker-0  
172.17.0.5	runner-ba2ea204-project-4-concurrent-0  
35.240.5.1	gitlab-host.my*  
**$ cat /etc/nsswitch.conf**  
*hosts: files dns*  
**$ docker login -u gitlab-ci-token -p $CI_BUILD_TOKEN gitlab-host.my**  
*WARNING! Using --password via the CLI is insecure. Use --password-stdin.  
Error response from daemon: Get https://gitlab-host.my/v2/: dial tcp: lookup   gitlab-host.my on 169.254.169.254:53: no such host*  
Образ создается всегда с тегом latest, не вижу смысла тратить ресурсы на отдельный на каждый коммит.  

Деплой. Пришло время научиться регистрировать Docker машину. Разбираться с копированием сертификатов и использовать драйвер *none* не стал, вариант с драйвером *generic* посчитал проще. Для разблокировки проектных ssh ключей, удалил метаданные  sshKeys инстанса докер-машины.  
В проект *example2 Gitlab CI* были добавлены переменные окружения с IP адресом сервера Gitlab CI и приватной частью ssh ллюча пользователя appuser:  
*GITLAB\_HOST*  
*APPUSER\_PRIV_KEY*  
IP адрес можно было выяснить и во время выполнения джоба, GCP internal DNS (прописывается в resolv.conf) разрешает имена инстансов, но посчитал приемлемым определить через переменную окружения.  

