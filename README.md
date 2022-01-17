# Scripts for running VINS-GPU/ROS with ArduPilot
This repository contains a ROS workspace for using stereo-visual navigation with ROS and ArduPilot.

The end result is the ability to use non-GPS navigation with ArduPilot, using a stereo camera.

# Components

Hardware:
- Stereo Camera. Global shutter preferred (such as https://www.arducam.com/product/arducam-1mp2-wide-angle-stereo-camera-for-raspberry-pi-jetson-nano-and-xavier-nx-dual-ov9281-monochrome-global-shutter-camera-module/)
- Nvidia Jetson Nano
- ArduPilot flight controller (connected to UART on Jetson 40-pin header)

Software:
- ROS Melodic
- VINS-GPU
- MAVROS

# How it works

The VINS-GPU (https://github.com/pjrambo/VINS-Fusion-gpu) algorithm is used as a ROS module to take in stereo camera images and generate a pose in 3D space. This pose is sent to ArduPilot via MAVROS and the VISION_POSITION_ESTIMATE message. ArduPilot then uses these messages as a non-GPS navigation source.

# Installation

Follow the instructions at https://www.arducam.com/docs/camera-for-jetson-nano/multiple-cameras-on-the-jetson/how-to-use-stereo-camera-to-perform-location-with-visual-slam/#35-algorithm-related-dependencies-installation, noting the following changes:

- Use `git clone https://github.com/stephendade/Camarray_HAT.git` repo in place of ``git clone -b ov9281_stereo https://github.com/ArduCAM/Camarray_HAT.git``
- Use `git clone https://github.com/stephendade/Nvidia_Jetson_ROS_SLAM_VINS.git` repo in place of ``git clone https://github.com/ArduCAM/Nvidia_Jetson_ROS_SLAM_VINS.git``
- Use this repository as your ROS workspace
- Install MAVROS via ``sudo apt install ros-melodic-mavros ros-melodic-mavros-extras``
- Use ``systemctl stop nvgetty && systemctl disable nvgetty`` on the Jetson and reboot to disable the system console on the UART.

# Configure
- If not using the ArduCAM OV9281 stereo camera, edit ``jetson.launch`` to suit your stereo camera setup
- Edit ``jetson.launch`` to point the to appropriate UART or UDP port for MAVROS.

# Running
Use ``launch.sh`` to run the ROS instance. If using a remote ROS node (for viewing, debugging, etc) edit the IP addresses in ``lanuch.sh`` as required.

