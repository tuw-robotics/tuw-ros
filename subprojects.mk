
ws00/src/teleop_tools:
		git clone -b foxy-devel git@github.com:ros-teleop/teleop_tools.git $@
		touch $@/COLCON_IGNORE

ws00/src/slam_toolbox:
		git clone -b humble git@github.com:SteveMacenski/slam_toolbox.git $@
		touch $@/COLCON_IGNORE

ws00/src/navigation2:
		git clone -b humble git@github.com:ros-planning/navigation2.git $@
		touch $@/COLCON_IGNORE

ws00/src/tuw2_gazebo:
		git clone -b ros2 git@github.com:tuw-robotics/tuw2_gazebo.git $@
		
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

ws02/src/mr_nav2:
		git clone -b main git@git.auto.tuwien.ac.at:mr/mr_nav2.git $@

clone-ws00: \
	ws00/src/teleop_tools \
	ws00/src/slam_toolbox \
	ws00/src/navigation2 \
	ws00/src/tuw2_gazebo 

clone-ws01: \
	ws01/src/Stage \
	ws01/src/stage_ros2  \
	ws01/src/marker_msgs 

clone-ws02: \
	ws02/src/tuw_geometry \
	ws02/src/tuw_msgs \
	ws02/src/tuw_laserscan_features  \
	ws02/src/mr_nav2 

clone: clone-ws00 clone-ws01 clone-ws02