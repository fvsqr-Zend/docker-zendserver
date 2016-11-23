#!make

PROJECT		?= phpcluster

ZS_VERSION ?= 9.0
PHP_VERSION ?= 7.0
WEBSERVER ?= apache
APP ?= magento

ZS_CONTAINER ?= zendserver
ZSCLIENT_CONTAINER ?= zsclient
EVENTDATA_CONTAINER ?= zs-eventdata

MYSQL_PWD ?= admin

###

DEPLOY_SCRIPT ?= deploy-$(APP).sh

SHELL           ?= /bin/bash

PROJECT_NORMALIZED ?= $(shell echo $(PROJECT) | tr -dc '[:alnum:]\n\r' | tr '[:upper:]' '[:lower:]')

DOCKER		?= docker
DOCKER_COMPOSE_FILE ?= ../ZendServer-$(ZS_VERSION)/php$(PHP_VERSION)/$(WEBSERVER)/docker-compose.yml
DOCKER_COMPOSE  ?= docker-compose -p $(PROJECT_NORMALIZED) -f $(DOCKER_COMPOSE_FILE)
DOCKER_COMPOSE_SETUP_FILE ?= setup-$(APP).yml
DOCKER_COMPOSE_SETUP  ?= docker-compose -p $(PROJECT_NORMALIZED) -f $(DOCKER_COMPOSE_SETUP_FILE) -f $(DOCKER_COMPOSE_FILE)
DOCKER_COMPOSE_NOISE_FILE ?= noise-$(APP).yml
DOCKER_COMPOSE_NOISE  ?= docker-compose -p $(PROJECT_NORMALIZED) -f $(DOCKER_COMPOSE_NOISE_FILE) -f $(DOCKER_COMPOSE_SETUP_FILE) -f $(DOCKER_COMPOSE_FILE)

###

.PHONY: deploy scale zray systeminfo eventdata-init eventdata-update zs-get-monitor_issues_performance zs-get-monitor_issues_resources zs-get-statistics_cpu_avg zs-get-statistics_request_processing_time zs-get-urlinsight open-php open-zs open exec-zs run-zsclient docker-build docker-info docker-up docker-kill-all build up stop clean help

default: help

###
# App specific targets
###
deploy: ##@App deploy application to cluster
	$(DOCKER_COMPOSE_SETUP) run --rm $(ZSCLIENT_CONTAINER) $(DEPLOY_SCRIPT)

scale: ##@App scale cluster to specified amount of nodes; usage example: make scale ZS=3
	$(DOCKER_COMPOSE) scale $(ZS_CONTAINER)=$(ZS)

zray: ##@App set Z-Ray URL directive to match to dynamically created cluster
	$(DOCKER_COMPOSE_SETUP) run --rm $(ZSCLIENT_CONTAINER) set-directive-zray.sh
	$(DOCKER_COMPOSE_SETUP) run --rm $(ZSCLIENT_CONTAINER) restart-zs.sh

systeminfo: ##@App multiple system information
	$(DOCKER_COMPOSE_SETUP) run --rm $(ZSCLIENT_CONTAINER) systeminfo.sh

###
# Noise targets: Generate event data and fetch monitoring events and statistics
###
eventdata-init: ##@Noise populate (pregenerated) data to the Zend Server database; update timestamps to match -2h to now
	$(DOCKER_COMPOSE_NOISE) run --rm $(EVENTDATA_CONTAINER) data_init.sh

eventdata-update: ##@Noise update timestamps of event data in Zend Server to match -2h to now
	$(DOCKER_COMPOSE_NOISE) run --rm $(EVENTDATA_CONTAINER) data_update.sh

zs-get-monitor_issues_performance: ##@Noise get all performance issues from Zend Server (Monitoring)
	$(DOCKER_COMPOSE_NOISE) run --rm $(ZSCLIENT_CONTAINER) monitor_issues_performance.sh

zs-get-monitor_issues_resources: ##@Noise get all resource issues from Zend Server (Monitoring)
	$(DOCKER_COMPOSE_NOISE) run --rm $(ZSCLIENT_CONTAINER) monitor_issues_resources.sh

zs-get-statistics_cpu_avg: ##@Noise get average CPU usage for a time range from Zend Server Statistics
	$(DOCKER_COMPOSE_NOISE) run --rm $(ZSCLIENT_CONTAINER) statistics_cpu_avg.sh

zs-get-statistics_request_processing_time: ##@Noise get min, max and avaergr Request Processing Time for a time range from Zend Server Statistics
	$(DOCKER_COMPOSE_NOISE) run --rm $(ZSCLIENT_CONTAINER) statistics_request_processing_time.sh

zs-get-urlinsight: ##@Noise get average CPU usage for a time range from Zend Server Statistics
	$(DOCKER_COMPOSE_NOISE) run --rm $(ZSCLIENT_CONTAINER) urlinsight.sh

###
# General targets
###
open-php:	##@General open PHP frontend in new Chrome browser tab
	@$(eval FORMAT={{ .NetworkSettings.Networks.$(PROJECT_NORMALIZED)_default.IPAddress }})
	@$(eval IP=$(shell docker inspect --format "$(FORMAT)" $(shell $(DOCKER_COMPOSE) ps -q $(ZS_CONTAINER) | sed -n 1p)))
	@/opt/google/chrome/chrome http://$(IP) --newtab

open-zs:	##@General open Zend Server UI in new Chrome browser tab
	$(eval FORMAT={{ .NetworkSettings.Networks.$(PROJECT_NORMALIZED)_default.IPAddress }})
	$(eval IP=$(shell docker inspect --format "$(FORMAT)" $(shell $(DOCKER_COMPOSE) ps -q $(ZS_CONTAINER) | sed -n 1p)))
	@/opt/google/chrome/chrome http://$(IP):10081 --newtab

open:	open-php open-zs	##@General open PHP and Zend Server frontend in new Chrome browser tab

exec-zs:	##@General open PHP application shell in container
	$(DOCKER) exec -ti $(shell $(DOCKER_COMPOSE) ps -q $(ZS_CONTAINER) | sed -n 1p) bash

run-zsclient:	##@General open PHP application shell in container
	$(DOCKER_COMPOSE_SETUP) run --rm $(ZSCLIENT_CONTAINER) -i

docker-build:	##@General build application images
	$(DOCKER_COMPOSE_SETUP) build

docker-info: ##@General name, hostname and container id from containers started with docker-compose
	@$(eval FORMAT={{ .Name }} {{.Config.Hostname }} {{ .NetworkSettings.Networks.$(PROJECT_NORMALIZED)_default.IPAddress }})
	@printf "\n%-30s %-20s %-40s\n" "Name" "ContainerID" "IP address"
	@echo "-------------------------------------------------------------------"
	@$(DOCKER) inspect --format "$(FORMAT)" $(shell $(DOCKER_COMPOSE) ps -q) | awk '{ printf "%-30s %-20s %-40s\n", $$1, $$2, $$3}'

docker-up: #@General start application
	$(DOCKER_COMPOSE) up -d
	$(DOCKER_COMPOSE) ps

docker-kill-all: #@General Caution: stops and removes all Docker containers
	$(DOCKER) stop $(shell $(DOCKER) ps -a -q)
	$(DOCKER) rm $(shell $(DOCKER) ps -a -q)

###
# Main targets
###

build: submodule-update docker-build init	##@Main build docker images and initialization of PHP and JS app

up: docker-up docker-info	##@Main start containers with docker-compose and display some status info

stop:	##@Main stop all running containers, started with docker-compose
	$(DOCKER_COMPOSE) stop

clean:  ##@Main remove application containers
	$(DOCKER_COMPOSE_SETUP) kill
	$(DOCKER_COMPOSE_SETUP) rm -fv --all
	-$(DOCKER_COMPOSE_SETUP) down

# Help based on https://gist.github.com/prwhite/8168133 thanks to @nowox and @prwhite
# And add help text after each target name starting with '\#\#'
# A category can be added with @category

HELP_FUN = \
		%help; \
		while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([\w-]+)\s*:.*\#\#(?:@([\w-]+))?\s(.*)$$/ }; \
		print "\nusage: make [target ...]\n\n"; \
	for (keys %help) { \
		print "$$_:\n"; \
		for (@{$$help{$$_}}) { \
			$$sep = "." x (25 - length $$_->[0]); \
			print "  $$_->[0]$$sep$$_->[1]\n"; \
		} \
		print "\n"; }

help:				##@system show this help
	#
	# General targets
	#
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)
