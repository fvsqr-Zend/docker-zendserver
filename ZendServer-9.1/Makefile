#!make

DOCKER ?= docker

default: help

#-------------------------------------------------------------------------------
# Default: Zend Server 9.1, PHP 7.1, Apache
#-------------------------------------------------------------------------------
zs-def:
	$(eval PROJECT_NAME = Zend Server 9.1, PHP 7.1, Apache)
	$(eval DOCKER_COMPOSE_FILE = docker-compose.yml)

zs-pull: zs-def prep pull ##@Default pull all necessary images (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-start: zs-def prep start info ##@Default start cluster (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-stop: zs-def prep stop ##@Default stop cluster (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-clean: zs-def prep clean ##@Default kill and remove all containers belonging to (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-single-start: zs-def prep single-start ##@Default start single server system (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)

#-------------------------------------------------------------------------------
# Helper: Zend Server 9.1, PHP 7.1, Apache, local dev built
#-------------------------------------------------------------------------------
zs-helper-def:
	$(eval PROJECT_NAME = Zend Server 9.1, PHP 7.1, Apache, Dev)
	$(eval DOCKER_COMPOSE_FILE = docker-compose.apache.dev.yml)

zs-helper-build: zs-helper-def prep build-zendserver ##@Helper build Zend Server image
zs-check-license: zs-helper-def prep check-license ##@Helper check Zend Server license; Usage: export ORDER_NR=<ORDER_NR>; export LICENSE=<LICENSE>; make zs-check-license


#-------------------------------------------------------------------------------
# Zend Server 9.1, PHP 7.1, Apache
#-------------------------------------------------------------------------------
zs-apache-def:
	$(eval PROJECT_NAME = Zend Server 9.1, PHP 7.1, Apache)
	$(eval DOCKER_COMPOSE_FILE = docker-compose.apache.yml)

zs-apache-pull: zs-apache-def prep pull ##@Apache pull all necessary images (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-apache-start: zs-apache-def prep start info ##@Apache start cluster (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-apache-stop: zs-apache-def prep stop ##@Apache stop cluster (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-apache-clean: zs-apache-def prep clean ##@Apache kill and remove all containers belonging to (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-apache-single-start: zs-apache-def prep single-start ##@Apache start single server system (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)

#-------------------------------------------------------------------------------
# Zend Server 9.1, PHP 7.1, Apache, local build of containers
#-------------------------------------------------------------------------------
zs-apache-dev-def:
	$(eval PROJECT_NAME = Zend Server 9.1, PHP 7.1, Apache, Dev)
	$(eval DOCKER_COMPOSE_FILE = docker-compose.apache.dev.yml)

zs-apache-dev-build: zs-apache-dev-def prep build ##@Apache-dev build all necessary images (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-apache-dev-force-build: zs-apache-dev-def prep force-build ##@Apache-dev force build all necessary images (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-apache-dev-start: zs-apache-dev-def prep start info ##@Apache-dev start cluster (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-apache-dev-stop: zs-apache-dev-def prep stop ##@Apache-dev stop cluster (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-apache-dev-clean: zs-apache-dev-def prep clean ##@Apache-dev kill and remove all containers belonging to (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-apache-dev-single-start: zs-apache-dev-def prep single-start single-info ##@Apache-dev start single server system (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)

#-------------------------------------------------------------------------------
# Zend Server 9.1, PHP 7.1, Nginx
#-------------------------------------------------------------------------------
zs-nginx-def:
	$(eval PROJECT_NAME = Zend Server 9.1, PHP 7.1, Nginx)
	$(eval DOCKER_COMPOSE_FILE = docker-compose.nginx.yml)

zs-nginx-pull: zs-nginx-def prep pull ##@Nginx build all necessary images (HAProxy; Zend Server 9.1, PHP 7.1, Nginx; MySQL)
zs-nginx-start: zs-nginx-def prep start info ##@Nginx start cluster (HAProxy; Zend Server 9.1, PHP 7.1, Nginx; MySQL)
zs-nginx-stop: zs-nginx-def prep stop ##@Nginx stop cluster (HAProxy; Zend Server 9.1, PHP 7.1, Nginx; MySQL)
zs-nginx-clean: zs-nginx-def prep clean ##@Nginx kill and remove all containers belonging to (HAProxy; Zend Server 9.1, PHP 7.1, Nginx; MySQL)
zs-nginx-single-start: zs-nginx-def prep single-start ##@Nginx start single server system (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)

#-------------------------------------------------------------------------------
# Zend Server 9.1, PHP 7.1, Nginx, local build of containers
#-------------------------------------------------------------------------------
zs-nginx-dev-def:
	$(eval PROJECT_NAME = Zend Server 9.1, PHP 7.1, Nginx, Dev)
	$(eval DOCKER_COMPOSE_FILE = docker-compose.nginx.dev.yml)

zs-nginx-dev-build: zs-nginx-dev-def prep build ##@Nginx-dev build all necessary images (HAProxy; Zend Server 9.1, PHP 7.1, Nginx; MySQL)
zs-nginx-dev-force-build: zs-nginx-dev-def prep force-build ##@Nginx-dev force build all necessary images (HAProxy; Zend Server 9.1, PHP 7.1, Nginx; MySQL)
zs-nginx-dev-start: zs-nginx-dev-def prep start info ##@Nginx-dev start cluster (HAProxy; Zend Server 9.1, PHP 7.1, Nginx; MySQL)
zs-nginx-dev-stop: zs-nginx-dev-def prep stop ##@Nginx-dev stop cluster (HAProxy; Zend Server 9.1, PHP 7.1, Nginx; MySQL)
zs-nginx-dev-clean: zs-nginx-dev-def prep clean ##@Nginx-dev kill and remove all containers belonging to (HAProxy; Zend Server 9.1, PHP 7.1, Nginx; MySQL)
zs-nginx-dev-single-start: zs-nginx-dev-def prep single-start ##@Nginx-dev start single server system (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)

#-------------------------------------------------------------------------------
# General recipes
#-------------------------------------------------------------------------------
prep:
	@$(eval PROJECT_NAME_SANITIZED = $(shell echo $(PROJECT_NAME) | tr -dc '[:alnum:]\n\r' | tr '[:upper:]' '[:lower:]'))
	@$(eval DOCKER_COMPOSE = docker-compose -p ${PROJECT_NAME_SANITIZED} -f ${DOCKER_COMPOSE_FILE})

info:
	@$(eval FORMAT={{ .Name }} {{.Config.Hostname }} {{ .NetworkSettings.Networks.${PROJECT_NAME_SANITIZED}_default.IPAddress }})
	@printf "%-40s %-20s %-40s\n" "Name" "ContainerID" "IP address"
	@echo "-----------------------------------------------------------------------------"
	@$(DOCKER) inspect --format "$(FORMAT)" `${DOCKER_COMPOSE} ps -q` | awk '{ printf "%-40s %-20s %-40s\n", $$1, $$2, $$3}'
	@echo "\nTo get the logs for Zend Server container run \ndocker logs -f ${PROJECT_NAME_SANITIZED}_zendserver_1\n"

single-info:
	@$(eval FORMAT={{ .Name }} {{.Config.Hostname }} {{ .NetworkSettings.Networks.${PROJECT_NAME_SANITIZED}_default.IPAddress }})
	@printf "%-40s %-20s %-40s\n" "Name" "ContainerID" "IP address"
	@echo "-----------------------------------------------------------------------------"
	@$(DOCKER) inspect --format "$(FORMAT)" `${DOCKER_COMPOSE} ps -q` | awk '{ printf "%-40s %-20s %-40s\n", $$1, $$2, $$3}'
	@echo "\nTo get the logs for Zend Server container run \ndocker logs -f ${PROJECT_NAME_SANITIZED}_zendserver_run_1\n"

build:
	@echo "\nBuilding ${PROJECT_NAME}"
	@echo "-----------------------------------------------------------------------------\n"
	${DOCKER_COMPOSE} build --force-rm
	@echo "\nDone.\n"

build-zendserver:
	@echo "\nBuilding Zend Server from ${PROJECT_NAME}"
	@echo "-----------------------------------------------------------------------------\n"
	${DOCKER_COMPOSE} build --force-rm zendserver
	@echo "\nDone.\n"

force-build:
	@echo "\nBuilding ${PROJECT_NAME}"
	@echo "-----------------------------------------------------------------------------\n"
	${DOCKER_COMPOSE} build --force-rm --no-cache
	@echo "\nDone.\n"

pull:
	@echo "\nPulling ${PROJECT_NAME}"
	@echo "-----------------------------------------------------------------------------\n"
	${DOCKER_COMPOSE} pull
	@echo "\nDone.\n"

start:
	@echo "\nStarting ${PROJECT_NAME}"
	@echo "-----------------------------------------------------------------------------\n"
	${DOCKER_COMPOSE} up -d
	@echo "\nDone.\n"

single-start:
	@echo "\nStarting ${PROJECT_NAME} (Single server)"
	@echo "-----------------------------------------------------------------------------\n"
	${DOCKER_COMPOSE} run -d -e CLUSTER= -p 10081:10081 zendserver
	@echo "\nDone.\n"

stop:
	@echo "\nStopping ${PROJECT_NAME}"
	@echo "-----------------------------------------------------------------------------\n"
	${DOCKER_COMPOSE} stop
	@echo "\nDone.\n"

clean:
	@echo "\nKilling and removing containers from ${PROJECT_NAME}"
	@echo "-----------------------------------------------------------------------------\n"
	${DOCKER_COMPOSE} kill
	${DOCKER_COMPOSE} rm -fv
	-${DOCKER_COMPOSE} down
	@echo "\nDone.\n"

check-license:
	${DOCKER_COMPOSE} run --rm -e ORDER_NR=${ORDER_NR} -e LICENSE=${LICENSE} zendserver /usr/local/zend/bin/php /check_lic.php

# Help based on https://gist.github.com/prwhite/8168133 thanks to @nowox and @prwhite
# And add help text after each target name starting with '\#\#'
# A category can be added with @category

HELP_FUN = \
		%help; \
		while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([\w-]+)\s*:.*\#\#(?:@([\w-]+))?\s(.*)$$/ }; \
		print "\n\nusage: make [target ...]\n\n"; \
	for (keys %help) { \
		print "$$_:\n"; \
		for (@{$$help{$$_}}) { \
			$$sep = "." x (35 - length $$_->[0]); \
			print "  $$_->[0] $$sep$$_->[1]\n"; \
		} \
		print "\n"; }

help:				##@system show this help
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)
