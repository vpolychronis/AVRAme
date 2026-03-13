from setuptools import find_packages, setup

package_name = 'avra_perception'

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='basilis',
    maintainer_email='basilis@todo.todo',
    description='TODO: Package description',
    license='TODO: License declaration',
    extras_require={
        'test': [
            'pytest',
        ],
    },
    entry_points={
        'console_scripts': [
		'camera_node = avra_perception.camera_node:main',
		'lidar_node = avra_perception.lidar_node:main',
		'yolo_vision_node = avra_perception.yolo_vision_node:main',
        ],
    },
)
