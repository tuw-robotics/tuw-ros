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

# dependencies for rviz2
RUN 
RUN apt-get install -y libqt5svg5-dev ament-cmake

USER ${MY_USER}
# change color in bash green -> red
RUN echo "export $CONTAINER_PROJECT_ENV_NAME=$CONTAINER_PROJECT_DIR" >> ~/.bashrc
RUN echo "if [ -f "env.sh" ]; then source env.sh; fi" >> ~/.bashrc

RUN echo "ros2 run rviz2 rviz2 -d ./ws01/src/stage_ros2/config/rviz/robot_ns.rviz  -t \"{NAMESPACE} - {CONFIG_PATH}/{CONFIG_FILENAME}\" --ros-args  -r /tf:=tf -r /tf_static:=tf_static -r __ns:=/robot_0" >> ~/.bash_history
RUN echo "tmuxinator start -p ws01/src/stage_ros2/tmuxinator/cave_one_robot.yml" >> ~/.bash_history

ENV TERM xterm-256color
WORKDIR ${CONTAINER_PROJECT_DIR}
ENV HOME=${MY_HOME}
CMD /bin/bash
