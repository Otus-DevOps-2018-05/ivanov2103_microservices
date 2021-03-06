cnf ?= .make_env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

.DEFAULT_GOAL := build-all

build-all: build-alertmanager build-prometheus build-mongodb_exporter build-comment build-ui build-post build-blackbox_exporter build-cloudprober build-telegraf build-fluentd

build-fluentd:
	cd $(REPO_PATH)/logging/fluentd && docker build -t $(USER_NAME)/fluentd .

build-telegraf:
	cd $(REPO_PATH)/monitoring/telegraf && docker build -t $(USER_NAME)/telegraf:latest .

build-alertmanager:
	cd $(REPO_PATH)/monitoring/alertmanager && docker build -t $(USER_NAME)/alertmanager:latest .

build-cloudprober:
	cd $(REPO_PATH)/monitoring/cloudprober && docker build -t $(USER_NAME)/cloudprober:latest .

build-prometheus:
	cd $(REPO_PATH)/monitoring/prometheus && docker build -t $(USER_NAME)/prometheus .

build-mongodb_exporter:
	cd $(REPO_PATH)/monitoring/mongodb_exporter && docker build -t $(USER_NAME)/mongodb_exporter:latest .

build-comment:
	cd $(REPO_PATH)/src/comment && bash docker_build.sh

build-ui:
	cd $(REPO_PATH)/src/ui && bash docker_build.sh

build-post:
	cd $(REPO_PATH)/src/post-py && bash docker_build.sh

build-blackbox_exporter:
	cd $(REPO_PATH)/monitoring/blackbox_exporter && docker build -t $(USER_NAME)/blackbox_exporter:latest .

push-all: push-alertmanager push-prometheus push-mongodb_exporter push-comment push-ui push-post push-blackbox_exporter push-cloudprober push-telegraf push-fluentd

push-fluentd:
	echo $(D_HUB_PASSWORD) | docker login -u $(USER_NAME) --password-stdin && docker push $(USER_NAME)/fluentd

push-telegraf:
	echo $(D_HUB_PASSWORD) | docker login -u $(USER_NAME) --password-stdin && docker push $(USER_NAME)/telegraf:latest

push-alertmanager:
	echo $(D_HUB_PASSWORD) | docker login -u $(USER_NAME) --password-stdin && docker push $(USER_NAME)/alertmanager:latest

push-cloudprober:
	echo $(D_HUB_PASSWORD) | docker login -u $(USER_NAME) --password-stdin && docker push $(USER_NAME)/cloudprober:latest

push-prometheus:
	echo $(D_HUB_PASSWORD) | docker login -u $(USER_NAME) --password-stdin && docker push $(USER_NAME)/prometheus

push-mongodb_exporter:
	echo $(D_HUB_PASSWORD) | docker login -u $(USER_NAME) --password-stdin && docker push $(USER_NAME)/mongodb_exporter:latest

push-comment:
	echo $(D_HUB_PASSWORD) | docker login -u $(USER_NAME) --password-stdin && docker push $(USER_NAME)/comment

push-ui:
	echo $(D_HUB_PASSWORD) | docker login -u $(USER_NAME) --password-stdin && docker push $(USER_NAME)/ui

push-post:
	echo $(D_HUB_PASSWORD) | docker login -u $(USER_NAME) --password-stdin && docker push $(USER_NAME)/post

push-blackbox_exporter:
	echo $(D_HUB_PASSWORD) | docker login -u $(USER_NAME) --password-stdin && docker push $(USER_NAME)/blackbox_exporter:latest

