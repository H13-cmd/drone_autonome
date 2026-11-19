#include <chrono>
#include <memory>
#include "rclcpp/rclcpp.hpp"
#include "sensor_msgs/msg/imu.hpp"

using namespace std::chrono_literals;

class ImuPublisher : public rclcpp::Node {
public:
  ImuPublisher() : Node("icm42688_node") {
    publisher_ = this->create_publisher<sensor_msgs::msg::Imu>(
        "/imu/data_raw", rclcpp::SensorDataQoS());
    timer_ = this->create_wall_timer(
        10ms, std::bind(&ImuPublisher::publish_imu, this));
  }

private:
  void publish_imu() {
    auto msg = sensor_msgs::msg::Imu();
    msg.header.stamp = this->get_clock()->now();
    msg.header.frame_id = "imu_link";
    msg.linear_acceleration.z = 9.81;
    publisher_->publish(msg);
  }

  rclcpp::Publisher<sensor_msgs::msg::Imu>::SharedPtr publisher_;
  rclcpp::TimerBase::SharedPtr timer_;
};

int main(int argc, char *argv[]) {
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<ImuPublisher>());
  rclcpp::shutdown();
  return 0;
}
