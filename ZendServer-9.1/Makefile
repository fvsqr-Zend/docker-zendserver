#!make

DOCKER ?= docker

default: help

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
zs-apache-localbuild-def:
	$(eval PROJECT_NAME = Zend Server 9.1, PHP 7.1, Apache, Local Build)
	$(eval DOCKER_COMPOSE_FILE = docker-compose.apache.local-build.yml)

zs-apache-localbuild-build: zs-apache-localbuild-def prep build ##@Apache-local-build build all necessary images (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-apache-localbuild-force-build: zs-apache-localbuild-def prep force-build ##@Apache-local-build force build all necessary images (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-apache-localbuild-start: zs-apache-localbuild-def prep start info ##@Apache-local-build start cluster (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-apache-localbuild-stop: zs-apache-localbuild-def prep stop ##@Apache-local-build stop cluster (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-apache-localbuild-clean: zs-apache-localbuild-def prep clean ##@Apache-local-build kill and remove all containers belonging to (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)
zs-apache-localbuild-single-start: zs-apache-localbuild-def prep single-start ##@Apache-local-build start single server system (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)

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
zs-nginx-localbuild-def:
	$(eval PROJECT_NAME = Zend Server 9.1, PHP 7.1, Nginx, Local Build)
	$(eval DOCKER_COMPOSE_FILE = docker-compose.nginx.local-build.yml)

zs-nginx-localbuild-build: zs-nginx-localbuild-def prep build ##@Nginx-local-build build all necessary images (HAProxy; Zend Server 9.1, PHP 7.1, Nginx; MySQL)
zs-nginx-localbuild-force-build: zs-nginx-localbuild-def prep force-build ##@Nginx-local-build force build all necessary images (HAProxy; Zend Server 9.1, PHP 7.1, Nginx; MySQL)
zs-nginx-localbuild-start: zs-nginx-localbuild-def prep start info ##@Nginx-local-build start cluster (HAProxy; Zend Server 9.1, PHP 7.1, Nginx; MySQL)
zs-nginx-localbuild-stop: zs-nginx-localbuild-def prep stop ##@Nginx-local-build stop cluster (HAProxy; Zend Server 9.1, PHP 7.1, Nginx; MySQL)
zs-nginx-localbuild-clean: zs-nginx-localbuild-def prep clean ##@Nginx-local-build kill and remove all containers belonging to (HAProxy; Zend Server 9.1, PHP 7.1, Nginx; MySQL)
zs-nginx-localbuild-single-start: zs-nginx-localbuild-def prep single-start ##@Nginx-local-build start single server system (HAProxy; Zend Server 9.1, PHP 7.1, Apache; MySQL)

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

build:
	@echo "\nBuilding ${PROJECT_NAME}"
	@echo "-----------------------------------------------------------------------------\n"
	${DOCKER_COMPOSE} build --force-rm
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
	${DOCKER_COMPOSE} run -d -e CLUSTER= zendserver
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
