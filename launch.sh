#!/bin/bash
source /opt/ros/melodic/setup.sh
source ./devel/setup.sh

export ROS_MASTER_URI=http://192.168.1.152:11311
export ROS_HOSTNAME=192.168.1.152
roslaunch jetson.launch
