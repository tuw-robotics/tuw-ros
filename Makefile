PROJECT_DIR = $(shell pwd)
SHELL = /bin/bash
BUILD_TYPE = Debug

all: help

help:
	@echo ""
	@echo "   Help Menu"
	@echo ""
	@echo "   make release          - builds all workspaces in release"
	@echo "   make clean            - removes from workspaces install, build, log"
	@echo "   make docker-build     - pulls base and builds develop"
	@echo "   make clone            - clones the subrepostories needed"
	@echo ""

docker-build:
	cd docker; make build; 

clean-ws00:
	rm -rf ./ws00/install ./ws00/build  ./ws00/log

clean-ws01:
	rm -rf ./ws01/install ./ws01/build  ./ws01/log

clean-ws02:
	rm -rf ./ws02/install ./ws02/build  ./ws02/log

clean: clean-ws00 clean-ws01 clean-ws02
	rm -rf ./install ./build  ./log

delete-packages:
	rm -rf ./ws00/src/*
	rm -rf ./ws01/src/*
	rm -rf ./ws02/src/*

build:  \
	build-ws00 \
	build-ws01 \
	build-ws02 \

build-ws00: 
	cd ${PROJECT_DIR}/ws00; \
	source /opt/ros/${ROS_DISTRO}/setup.bash; \
	colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=${BUILD_TYPE}; \

build-ws01: 
	cd ${PROJECT_DIR}/ws01; \
	source /opt/ros/${ROS_DISTRO}/setup.bash; \
	source ${PROJECT_DIR}/ws00/install/setup.bash; \
	colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=${BUILD_TYPE} --packages-select Stage --cmake-args -DOpenGL_GL_PREFERENCE=LEGACY; \
	colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=${BUILD_TYPE}

build-ws02: 
	source /opt/ros/${ROS_DISTRO}/setup.bash; \
	source ${PROJECT_DIR}/ws00/install/setup.bash; \
	source ${PROJECT_DIR}/ws01/install/setup.bash; \
	cd ${PROJECT_DIR}/ws02; \
	colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=${BUILD_TYPE}

ws00/src/teleop_tools:
		git clone -b foxy-devel git@github.com:ros-teleop/teleop_tools.git $@
		touch $@/COLCON_IGNORE

ws00/src/slam_toolbox:
		git clone -b humble git@github.com:SteveMacenski/slam_toolbox.git $@
		touch $@/COLCON_IGNORE

ws00/src/navigation2:
		git clone -b humble git@github.com:ros-planning/navigation2.git $@
		touch $@/COLCON_IGNORE

ws01/src/Stage:
		git clone -b ros2 git@github.com:tuw-robotics/Stage.git $@

ws01/src/stage_ros2:
		git clone -b humble git@github.com:tuw-robotics/stage_ros2.git $@

ws01/src/marker_msgs:
		git clone -b ros2 git@github.com:tuw-robotics/marker_msgs.git $@

ws02/src/tuw_msgs:
		git clone -b ros2 git@github.com:tuw-robotics/tuw_msgs.git $@

ws02/src/tuw_geometry:
		git clone -b ros2 git@github.com:tuw-robotics/tuw_geometry.git $@

ws02/src/tuw_laserscan_features:
		git clone -b ros2 git@github.com:tuw-robotics/tuw_laserscan_features.git $@


clone-ws00: \
	ws00/src/teleop_tools \
	ws00/src/slam_toolbox \
	ws00/src/navigation2

clone-ws01: \
	ws01/src/Stage \
	ws01/src/stage_ros2  \
	ws01/src/marker_msgs 

clone-ws02: \
	ws02/src/tuw_geometry \
	ws02/src/tuw_msgs \
	ws02/src/tuw_laserscan_features 

clone: clone-ws00 clone-ws01 clone-ws02

pull:
	git pull origin
	find . -type d -name .git -exec echo {} \; -exec git --git-dir={} --work-tree=${PROJECT_DIR}/{}/.. pull origin \;
