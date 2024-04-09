# Create Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  name             = "${var.PROJECT_NAME}-asg"
  desired_capacity = 1
  max_size         = 5
  min_size         = 0

  vpc_zone_identifier = data.aws_subnets.available_subnets.ids

  launch_template {
    id      = aws_launch_template.ec2-tpl.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.tg-ec2.arn]

}

resource "aws_autoscaling_policy" "asg-policy" {
  name                   = "${var.PROJECT_NAME}-asg-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}


output "asg_output" {
  value = aws_autoscaling_group.asg.name
}