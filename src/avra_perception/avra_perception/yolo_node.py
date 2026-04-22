import rclpy
from rclpy.node import Node
from avra_interfaces.msg import BuoyDetection

class DummyYoloNode(Node):
    def __init__(self):
        super().__init__('yolo_vision_node_front')
        self.publisher_ = self.create_publisher(BuoyDetection, '/vision/front/buoys', 10)
        self.timer = self.create_timer(1.0, self.publish_dummy_data)

    def publish_dummy_data(self):
        msg = BuoyDetection()
        msg.header.stamp = self.get_clock().now().to_msg()
        msg.header.frame_id = "camera_front"
        msg.color = "red"
        msg.distance = 5.2
        msg.angle = 0.15

        self.publisher_.publish(msg)
        self.get_logger().info(f"Σήμα: {msg.color} | {msg.distance}m | {msg.angle}rad")

def main(args=None):
    rclpy.init(args=args)
    node = DummyYoloNode()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
