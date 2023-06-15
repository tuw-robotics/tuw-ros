OWNER = tuwrobotics
OWNER-ALAB = registry.auto.tuwien.ac.at/mr/mr_root
PREFIX = mr
CONTAINER_PROJECT_ENV_NAME = MR_DIR
CONTAINER_PROJECT_FOLDER_NAME = mobile_robotics
DOCKER_BUILD_ARG = --rm -t
#DOCKER_BUILD_ARG = "--rm -t --squash"
BASE_CONTAINER = tuw-${ROS_DISTRO}-ide	

ROS_DISTRO = humble
HOST_PROJECT_DIR = $(shell cd ..; pwd)
HOSTNAME := $(shell hostname)
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
	@docker build ${DOCKER_BUILD_ARG} ${PREFIX}-${ROS_DISTRO} \
					--build-arg OWNER=${OWNER} \
					--build-arg BASE_CONTAINER=${BASE_CONTAINER} \
					--build-arg CONTAINER_PROJECT_ENV_NAME=${CONTAINER_PROJECT_ENV_NAME} \
					--build-arg CONTAINER_PROJECT_FOLDER_NAME=${CONTAINER_PROJECT_FOLDER_NAME} \
					-f Dockerfile  ../

build-alab:
	@docker build ${DOCKER_BUILD_ARG} ${PREFIX}-${ROS_DISTRO} \
					--build-arg OWNER=${OWNER-ALAB} \
					--build-arg BASE_CONTAINER=${BASE_CONTAINER} \
					--build-arg CONTAINER_PROJECT_ENV_NAME=${CONTAINER_PROJECT_ENV_NAME} \
					--build-arg CONTAINER_PROJECT_FOLDER_NAME=${CONTAINER_PROJECT_FOLDER_NAME} \
					-f Dockerfile  ../


run:
	@docker run -ti -e "TERM=xterm-256color" --rm --privileged \
	    --network="host" --env="DISPLAY" \
	    --add-host "${HOSTNAME}-${PREFIX}:127.0.0.1" \
	    --hostname ${HOSTNAME}-${PREFIX} \
	    --name ${HOSTNAME}-${PREFIX} \
		-v /dev/shm:/dev/shm \
		-v ${HOST_PROJECT_DIR}:/opt/projects/${CONTAINER_PROJECT_FOLDER_NAME} \
		${PREFIX}-${ROS_DISTRO}

run-alab:
	@docker run -ti -e "TERM=xterm-256color" --rm --privileged \
	    --network="host" --env="DISPLAY" \
	    --add-host "${HOSTNAME}-${PREFIX}:127.0.0.1" \
	    --hostname ${HOSTNAME}-${PREFIX} \
	    --name ${HOSTNAME}-${PREFIX} \
		-v /dev/shm:/dev/shm \
		-v /local/home/robot/projects/${CONTAINER_PROJECT_FOLDER_NAME}:/local/home/robot/projects/${CONTAINER_PROJECT_FOLDER_NAME} \
		${PREFIX}-${ROS_DISTRO}

create:
	@docker create -e "TERM=xterm-256color" --privileged \
	    --network="host" --env="DISPLAY" \
	    --add-host "${HOSTNAME}-${PREFIX}:127.0.0.1" \
	    --hostname ${HOSTNAME}-${PREFIX} \
	    --name ${HOSTNAME}-${PREFIX} \
		-v /dev/shm:/dev/shm \
		--entrypoint /entrypoint-keep-running.sh  \
		-v ${HOST_PROJECT_DIR}:/opt/projects/${CONTAINER_PROJECT_FOLDER_NAME} \
		${PREFIX}-${ROS_DISTRO}
															
attach:
	@docker  exec -it ${HOSTNAME}-${PREFIX} bash 

start:
	@docker  start -i ${HOSTNAME}-${PREFIX}

stop:
	@docker  stop ${HOSTNAME}-${PREFIX}
	
rm:
	@docker  rm ${HOSTNAME}-${PREFIX}