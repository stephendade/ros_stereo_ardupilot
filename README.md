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
- VINS-GPU Lite
- MAVROS

# How it works

The VINS_Lite_GPU (https://github.com/KopiSoftware/VINS_Lite_GPU) algorithm is used as a ROS module to take in stereo camera images and generate a pose in 3D space. This pose is sent to ArduPilot via MAVROS and the VISION_POSITION_ESTIMATE message. ArduPilot then uses these messages as a non-GPS navigation source.

Note the VINS_Lite_GPU used here is slightly modified from source - adding a odometry message compatible with MAVROS.

It is a "lighter" version of VINS-GPU (https://github.com/pjrambo/VINS-Fusion-gpu) which allows for better realtime performance on a Jetson Nano.

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

Ardupilot will need the following parameters:

```
SCHED_LOOP_RATE  250 
VISO_DELAY_MS    150
VISO_ORIENT      0
VISO_POS_M_NSE   0.100000
VISO_POS_X       0.000000
VISO_POS_Y       0.000000
VISO_POS_Z       0.000000
VISO_SCALE       1.000000
VISO_TYPE        2
VISO_VEL_M_NSE   0.010000
VISO_YAW_M_NSE   0.100000
```

# Running
Use ``launch.sh`` to run the ROS instance. If using a remote ROS node (for viewing, debugging, etc) edit the IP addresses in ``launch.sh`` as required.

When connecting a ground station, ensure the streamrate is 20Hz. This is required for the VINS inertial message (/mavros/imu/data) input.


