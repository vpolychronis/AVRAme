# This is an auto generated Dockerfile for ros:ros-base
# generated from docker_images_ros2/create_ros_image.Dockerfile.em
FROM ros:humble-ros-core-jammy

# install bootstrap tools 
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    git \
    nano \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-rosdep \
    python3-vcstool \
    ros-humble-ros-base=0.10.0-1* \
    ros-humble-demo-nodes-cpp \
    ros-humble-demo-nodes-py \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO

# setup colcon mixin and metadata
RUN colcon mixin add default \
      https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml && \
    colcon mixin update && \
    colcon metadata add default \
      https://raw.githubusercontent.com/colcon/colcon-metadata-repository/master/index.yaml && \
    colcon metadata update

# additional libraries for each subteam
#RUN apt-get update && apt-get install -y --no-install-recommends \
    # Control
    #
    #
    #
    #
    # Navigation & Localization
    #
    #
    #
    #
    # Perception
    #
    #
    #
    #
    # Telecoms
    #
    #
    #
    #
    #&& rm -rf /var/lib/apt/lists/*    

# Sets the workspace automatically
WORKDIR /home/ros/avra_ws

# Source ROS 2 for every new terminal session
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc && \
    echo "if [ -f /home/ros/avra_ws/install/setup.bash ]; then source /home/ros/avra_ws/install/setup.bash; fi" >> /root/.bashrc
