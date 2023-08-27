# skript to source a ros2 project

export ROS_DISTRO=humble
export PROJECT_DIR=${TUW_ROS_DIR}
source /opt/ros/$ROS_DISTRO/setup.bash
#export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
#export FASTRTPS_DEFBAULT_PROFILES_FILE=$(pwd)/fastrtps.xml 
#export RMW_FASTRTPS_USE_QOS_FROM_XML=0
#export RMW_IMPLEMENTATION=rmw_gurumdds_cpp
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

source_ws () {
    if [ -f "$1" ]; then
        source $1
        echo "sourced $1"
    else 
        echo "$1 does not exist."
    fi
}

echo "** ROS2 $ROS_DISTRO initialized with $RMW_IMPLEMENTATION **"
source_ws ${PROJECT_DIR}/ws00/install/setup.bash
source_ws ${PROJECT_DIR}/ws01/install/setup.bash
source_ws ${PROJECT_DIR}/ws02/install/setup.bash
