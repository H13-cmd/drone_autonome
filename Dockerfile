FROM ros:humble-ros-base

ENV DEBIAN_FRONTEND=noninteractive

# 1. Outils système, compilation C++, SPI/UART et support caméra (libcamera)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    nano \
    udev \
    python3-pip \
    python3-colcon-common-extensions \
    python3-rosdep \
    libopencv-dev \
    python3-opencv \
    libeigen3-dev \
    libserial-dev \
    libcamera-dev \
    libcamera-tools \
    i2c-tools \
    spi-tools \
    v4l-utils \
    ros-humble-camera-ros \
    ros-humble-cv-bridge \
    ros-humble-image-transport \
    ros-humble-sensor-msgs \
    ros-humble-nav-msgs \
    ros-humble-tf2-ros \
    ros-humble-tf2-geometry-msgs \
    && rm -rf /var/lib/apt/lists/*

# 2. Bibliothèques Python (MAVLink et communication série TELEM2)
RUN pip3 install --no-cache-dir \
    pymavlink \
    pyserial \
    numpy

# 3. Workspace ROS 2 et sourçage automatique
WORKDIR /ros2_ws
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc && \
    echo "[ -f /ros2_ws/install/setup.bash ] && source /ros2_ws/install/setup.bash" >> /root/.bashrc

CMD ["bash"]