# TU Wien Robotics ROS-Root 

## Initial Setup

### .bashrc

The `env.sh` file should be sourced automatically, when it is found in a folder. Thus, add the below commands to your `.bashrc`. The `PROJECTS_DIR`, `TUW_ROS_DIR` and `ROS_DISTRO` need to be set accordingly.
```sh
echo 'export ROS_DISTRO=humble' >> ~/.bashrc
echo 'export PROJECTS_DIR=${HOME}/projects' >> ~/.bashrc
echo 'export TUW_ROS_DIR=${PROJECTS_DIR}/tuw-ros' >> ~/.bashrc
echo 'source /opt/ros/${ROS_DISTRO}/setup.bash' >> ~/.bashrc
echo "if [ -f "env.sh" ]; then source env.sh; fi" >> ~/.bashrc
```

### subprojects
The file `subprojects.mk` holds a list with all subprojects. You just need to run `make clone`.

## Docker
There is a docker file ready
```sh
cd docker
make build
make run
```

## How to run unit and ROS tests
[https://docs.ros.org/en/iron/Tutorials/Intermediate/Testing/CLI.html]
```
sudo apt-get install ros-$ROS_DISTRO-ament-cmake-*
export YOUR_PKG=tuw_geometry
export YOUR_PKG=tuw_msgs
export SELECT=select
export SELECT=up-to
colcon build --packages-$SELECT $YOUR_PKG --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Debug --cmake-args -DBUILD_TESTING=true
colcon test --ctest-args tests --packages-$SELECT $YOUR_PKG
colcon test-result
colcon test-result --verbose
cd src/$YOUR_PKG
ament_clang_format
ament_clang_format --reformat
ament_uncrustify . --reformat
```
