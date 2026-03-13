//Test code
#include "rclcpp/rclcpp.hpp"

// This is the "Skeleton" of your node
class SensorFusionNode : public rclcpp::Node {
public:
    SensorFusionNode() : Node("sensor_fusion_node") {
        RCLCPP_INFO(this->get_logger(), "Sensor Fusion Node has started.");
    }
};

// --- THIS IS THE PART YOU ARE MISSING ---
int main(int argc, char ** argv)
{
  rclcpp::init(argc, argv);
  // This line creates the node and keeps it alive
  rclcpp::spin(std::make_shared<SensorFusionNode>());
  rclcpp::shutdown();
  return 0;
}
