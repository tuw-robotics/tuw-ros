OWNER = tuwrobotics
PREFIX = tuw
PROJECT_NAME = mrrp2
CONTAINER_PROJECT_ENV_NAME = MRRP2_DIR
DOCKER_BUILD_ARG = --rm -t
#DOCKER_BUILD_ARG = "--rm -t --squash"
BASE_CONTAINER = tuw-${ROS_DISTRO}-ide	

ROS_DISTRO = humble
HOST_PROJECT_DIR = $(shell cd ..; pwd)
HOSTNAME := $(shell hostname)
CURRENT_UID := $(shell id -u)
CURRENT_GID := $(shell id -g)
CONTAINER_PROJECTS_DIR = /home/${USER}/projects

RUN = develop
TAG = latest 

all: help

help:
	@echo ""
	@echo "   Help Menu"
	@echo ""
	@echo "   make build                - builds images"
	@echo "   make build-alab           - builds images"
	@echo "   make run                  - runs container"
	@echo "   make login USER=username  - login container registry"
	@echo ""

login:
	@docker login registry.auto.tuwien.ac.at -u $(USER)
	
build:
	@docker build ${DOCKER_BUILD_ARG} ${OWNER}/${PROJECT_NAME}-${USER} \
					--build-arg OWNER=osrf \
					--build-arg BASE_CONTAINER=ros:${ROS_DISTRO}-desktop \
					--build-arg MY_USER=${USER} \
					--build-arg MY_UID=${CURRENT_UID} \
					--build-arg MY_GID=${CURRENT_GID} \
					--build-arg CONTAINER_PROJECT_ENV_NAME=${CONTAINER_PROJECT_ENV_NAME} \
					--build-arg CONTAINER_PROJECTS_DIR=${CONTAINER_PROJECTS_DIR} \
					--build-arg CONTAINER_PROJECT_NAME=${PROJECT_NAME} \
					-f Dockerfile ./

run:
	@docker run -ti -e "TERM=xterm-256color" --rm --privileged \
	    --network="host" --env="DISPLAY" \
	    --add-host "${HOSTNAME}-${PREFIX}:127.0.0.1" \
	    --hostname ${HOSTNAME}-${PREFIX} \
	    --name ${HOSTNAME}-${PREFIX} \
		-v /dev/shm:/dev/shm \
		-v ${HOST_PROJECT_DIR}:${CONTAINER_PROJECTS_DIR}/${PROJECT_NAME} \
		${OWNER}/${PROJECT_NAME}-${USER}