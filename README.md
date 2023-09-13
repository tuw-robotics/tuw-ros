# TU Wien Robotics ROS-Root 

## Setup and Install
### .bashrc
Prepare your .bashrc so that your work space get sourced if you open a terminal in work space with an env.sh file. All other ROS project sourcing commands in your .bashrc should be removed!
```
echo 'export ROS_DISTRO=humble' >> ~/.bashrc
echo 'export PROJECTS_DIR=${HOME}/projects' >> ~/.bashrc
echo 'export TUW_ROS_DIR=${PROJECTS_DIR}/tuw-ros' >> ~/.bashrc
echo 'source /opt/ros/${ROS_DISTRO}/setup.bash' >> ~/.bashrc
echo "if [ -f "env.sh" ]; then source env.sh; fi" >> ~/.bashrc
```


### subprojects
The file subprojects.mk holds a list with all subprojects. You just need to run `make clone`. 
```
cd $TUW_ROS_DIR
make clone 
```
## VSCode
The project is allrady configured for vscode just start it from __$TUW_ROS_DIR__

```
cd ${TUW_ROS_DIR}
code .
```
## Docker
There is a docker file ready
```
cd ${TUW_ROS_DIR}/docker
make build
make run
```


## How to run unit and ROS tests
```
export YOUR_PKG=tuw_geometry
colcon build --packages-select $YOUR_PKG --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Debug --cmake-args -DBUILD_TESTING=true
colcon test --packages-select $YOUR_PKG
colcon test-result
colcon test-result --verbose
cd src/$YOUR_PKG
ament_clang_format
ament_clang_format --reformat
ament_uncrustify . --reformat
```