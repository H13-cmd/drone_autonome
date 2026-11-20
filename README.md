# Autonomous Drone — ROS 2 Humble Docker Setup

Multi-architecture (`amd64` / `arm64`) **ROS 2 Humble** Docker environment built with OpenCV, Eigen, and `pymavlink` for GPS-denied autonomous drone navigation using ArduPilot, Pixhawk 6C, and a Raspberry Pi 5.

## Hardware & Target Environment
* **Companion Computer:** Raspberry Pi 5 (Ubuntu Server 24.04 `arm64`)
* **Flight Controller:** Pixhawk 6C running ArduPilot Copter (connected via `TELEM2` UART)
* **Sensors:** IMX296 Global Shutter Camera, ICM-42688-P SPI IMU, MTF-02P Optical Flow / Rangefinder

## Prerequisites (Host Setup)
On a fresh Raspberry Pi 5 (Ubuntu 24.04) or WSL2 Ubuntu host, install Git and Docker:
```bash
sudo apt update
sudo apt install -y git docker.io docker-compose-v2
sudo usermod -aG docker $USER
newgrp docker
```

## Quick Start (After Cloning/Pulling)

1. **Clone the repository and enter the directory:**
   ```bash
   git clone [https://github.com/H13-cmd/drone_autonome.git](https://github.com/H13-cmd/drone_autonome.git)
   cd drone_autonome
   ```

2. **Build the Docker image and start the container in the background:**
   ```bash
   docker compose up -d --build
   ```

3. **Enter the running container (`drone` service):**
   ```bash
   docker compose exec drone bash
   ```

4. **Compile and source the ROS 2 workspace (inside the container):**
   ```bash
   colcon build --symlink-install
   source /opt/ros/humble/setup.bash
   source install/setup.bash
   ```

5. **Run a ROS 2 node:**
   ```bash
   ros2 run imu_driver imu_node
   ```

## Inspecting Topics (Second Terminal)
While a node is running in the first terminal, open a second SSH session on the Raspberry Pi 5 and attach to the same running container:
```bash
cd ~/drone_autonome
docker compose exec drone bash
source /opt/ros/humble/setup.bash
source install/setup.bash
ros2 topic list
ros2 topic echo /imu/data_raw
```

## Repository Structure
* `Dockerfile` — ROS 2 Humble base image with OpenCV, Eigen, and `pymavlink`.
* `docker-compose.yml` — Container configuration (`drone` service / `drone_dev` container), volume mounts, and hardware access.
* `src/` — Local ROS 2 packages (`imu_driver`, `mavlink_bridge`).