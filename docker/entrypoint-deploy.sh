#!/bin/bash
set -e

unset ROS_DISTRO
/opt/TurboVNC/bin/vncserver -localhost -securitytypes NONE :1 
tail -f /dev/null 
exec "$@"
