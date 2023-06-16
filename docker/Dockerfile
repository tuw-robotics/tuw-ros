ARG OWNER=osrf
ARG ROS_DISTRO=humble
ARG UBUNTU_DISTRO=jammy
ARG BASE_CONTAINER=ros:${ROS_DISTRO}-desktop
ARG ROOT_CONTAINER=$OWNER/$BASE_CONTAINER 
FROM $ROOT_CONTAINER

ARG CONTAINER_PROJECT_ENV_NAME="MY_PROJECT_DIR"
ENV CONTAINER_PROJECT_ENV_NAME=${CONTAINER_PROJECT_ENV_NAME}

USER root

RUN apt-get update && apt-get -y upgrade
# dependencies for stage and stage_ros2
RUN apt-get install -y git cmake g++ libjpeg8-dev libpng-dev libglu1-mesa-dev libltdl-dev libfltk1.1-dev
RUN pip install setuptools==58.2.0

USER ${MY_USER}
# change color in bash green -> red
RUN echo "export $CONTAINER_PROJECT_ENV_NAME=$CONTAINER_PROJECT_DIR" >> ~/.bashrc
RUN echo "if [ -f "env.sh" ]; then source env.sh; fi" >> ~/.bashrc

ENV TERM xterm-256color
WORKDIR ${CONTAINER_PROJECT_DIR}
ENV HOME=${MY_HOME}
CMD /bin/bash