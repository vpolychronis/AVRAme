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

# --------------------------------------------------------------------------    
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
# --------------------------------------------------------------------------     


# create a new user so that nothing gets uploaded as root
# argument definition 
ARG USERNAME=ros
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# create a user that matches Host UID/GID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# set permissions for the workspace
# create the folder and give ownership to this new user
RUN mkdir -p /home/ros/avra_ws && chown -R $USERNAME:$USERNAME /home/ros/avra_ws

# switch to the new user
USER $USERNAME 

# sets the workspace automatically
WORKDIR /home/ros/avra_ws

# source ROS 2 for every new terminal session
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc && \
    echo "if [ -f /home/ros/avra_ws/install/setup.bash ]; then source /home/ros/avra_ws/install/setup.bash; fi" >> ~/.bashrc

# AVRA PROJECT - CONTAINER ALIASES

# create the aliases in the ros user .bashrc
RUN echo "alias cw='cd /home/ros/avra_ws'" >> ~/.bashrc && \
    echo "alias sb='source /home/ros/avra_ws/install/setup.bash'" >> ~/.bashrc && \
    echo "alias build='colcon build --symlink-install && sb'" >> ~/.bashrc && \
    echo "alias nodes='ros2 node list'" >> ~/.bashrc && \
    echo "alias topics='ros2 topic list'" >> ~/.bashrc

# add a visual indicator to the prompt 
RUN echo "export PS1='\[\033[01;32m\][AVRA-DOCKER]\[\033[00m\] \w \$ '" >> ~/.bashrc

# fixes the rosdep permissions
RUN sudo rosdep fix-permissions && rosdep update