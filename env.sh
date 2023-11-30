# skript to source a ros2 project
export ROS_DISTRO=humble
export ROS_DOMAIN_ID=1
export PROJECT_DIR=${TUW_ROS_DIR}
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

source_ws () {
    if [ -f "$1" ]; then
        source $1
        echo "sourced $1"
    else 
        echo "$1 does not exist."
    fi
}
source_ws source.sh
