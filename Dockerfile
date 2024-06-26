# Use the official ROS Humble image as the base image
FROM osrf/ros:humble-desktop-full

# Install required packages
RUN apt-get update && apt-get install -y \
    wget \
    git \
    nano \
    ros-humble-can-msgs \
    ros-humble-teleop-twist-keyboard \
    ros-humble-velodyne* \
    can-utils \
    iproute2 && \
    rm -rf /var/lib/apt/lists/*

# Create a Colcon workspace and set it up
RUN mkdir -p /root/ros2_ws/src
# Copy the vehicle_interface repository and the ros2_socketcan repository
COPY files/ros2_socketcan /root/ros2_ws/src
COPY files/SD-VehicleInterface /root/ros2_ws/src

WORKDIR /root/ros2_ws
# Build the Colcon workspace
RUN /bin/bash -c "source /opt/ros/humble/setup.bash; colcon build"

# Source the ROS environment and the Colcon workspace in the entry point
# and create an alias for the keyboardlaunch script and the vehicle_interface launch file
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc && \
    echo "source /root/ros2_ws/install/setup.bash" >> /root/.bashrc && \
    echo "alias lidar='ros2 launch velodyne velodyne-all-nodes-VLP16-launch.py'" >> /root/.bashrc && \
    echo "alias vi_launch='ros2 launch sd_vehicle_interface sd_vehicle_interface.launch.xml sd_vehicle:=twizy sd_gps_imu:=peak'" >> /root/.bashrc

# Set the working directory to the root folder
WORKDIR /root