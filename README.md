# Autonomous Drone — ROS 2 Humble Docker Setup

Multi-architecture (`amd64` / `arm64`) **ROS 2 Humble** Docker environment built with OpenCV, Eigen, and `pymavlink` for GPS-denied autonomous drone navigation using ArduPilot, Pixhawk 6C, and a Raspberry Pi 5.

## Prerequisites
* **Docker** and **Docker Compose** installed on your host machine (WSL2 Ubuntu or Raspberry Pi 5 Ubuntu 22.04).

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

3. **Enter the running container:**
   ```bash
   docker compose exec ros2_dev bash
   ```

4. **Compile and source the ROS 2 workspace (inside the container):**
   ```bash
   colcon build --symlink-install
   source install/setup.bash
   ```

5. **Run a node to verify the setup:**
   ```bash
   ros2 run imu_driver imu_node
   ```

## Repository Structure
* `Dockerfile` — ROS 2 Humble base image with OpenCV, Eigen, and `pymavlink`.
* `docker-compose.yml` — Container configuration, volume mounts, and hardware device mapping.
* `src/` — Local ROS 2 packages (`imu_driver`, `mavlink_bridge`).