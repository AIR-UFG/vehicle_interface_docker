# Vehicle Interface inside Docker

This repository contains the code to run the Vehicle Interface inside a Docker container for use in the StreetDrone Renault Twizy. The Vehicle Interface is a ROS package that provides an interface to the Twizy's CAN bus and autonomous driving capabilities.

## Setup

## Clone the repository

Clone this repository and navigate to it.

```bash
git clone --recurse-submodules https://github.com/AIR-UFG/vehicle_interface_docker.git
cd vehicle_interface_docker
```

## Build the Docker image

Build the Docker image using the following command:

```bash
docker build -t vehicle_interface:humble .
```

## Run the Docker container

To run the Docker container, utilize the provided run script with the following parameters:

```bash
./run.sh vehicle_interface:humble --rm --nvidia
```

`<image-name>`: The name you assigned to the Docker image during the build process.
`--rm`: Automatically remove the container when it exits.
`--nvidia`: Run the container with NVIDIA GPU support.

After running the container, a `shared-folder` folder will be created within the repository directory. This folder will be used to share data between the host and the container. That folder will be linked to the `/root/shared-folder` directory within the container.

## Usage

To start the Vehicle Interface, run the following command within the container:

```bash
ros2 launch sd_vehicle_interface sd_vehicle_interface.launch.xml sd_vehicle:=twizy sd_gps_imu:=peak
```

If you need to attach to the container's shell, run the following command:

```bash
docker exec -it vehicle_interface bash
```