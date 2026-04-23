import rclpy
from rclpy.node import Node
from avra_interfaces.msg import BuoyDetection

class PilotNode(Node):
    def __init__(self):
        super().__init__('pilot_node')
        # Δημιουργούμε τον Subscriber που ακούει στο ίδιο topic
        self.subscription = self.create_subscription(
            BuoyDetection,
            '/vision/front/buoys',
            self.listener_callback,
            10)
        self.get_logger().info('Ο Πιλότος ξεκίνησε και περιμένει δεδομένα από την κάμερα...')

    def listener_callback(self, msg):
        # Εδώ ορίζουμε την "αντίδραση" του σκάφους
        if msg.distance < 3.0:
            status = "ΚΙΝΔΥΝΟΣ! Πολύ κοντά."
        else:
            status = "Ασφαλής απόσταση."
            
        self.get_logger().info(f'Άκουσα: {msg.color} σημαδούρα στα {msg.distance:.2f}m -> {status}')

def main(args=None):
    rclpy.init(args=args)
    node = PilotNode()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()