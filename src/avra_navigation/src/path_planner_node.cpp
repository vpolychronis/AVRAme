//Test code
#include "rclcpp/rclcpp.hpp"

// This is the "Skeleton" of your node
class PathPlannerNode : public rclcpp::Node {
public:
    PathPlannerNode() : Node("path_planner_node") {
        RCLCPP_INFO(this->get_logger(), "Path Planner Node has started.");
    }
};

// --- THIS IS THE PART YOU ARE MISSING ---
int main(int argc, char ** argv)
{
  rclcpp::init(argc, argv);
  // This line creates the node and keeps it alive
  rclcpp::spin(std::make_shared<PathPlannerNode>());
  rclcpp::shutdown();
  return 0;
}
