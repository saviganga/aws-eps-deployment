resource "aws_autoscaling_group" "ecs_asg" {
  vpc_zone_identifier = data.aws_subnets.available_subnets.ids
  desired_capacity    = var.ASG_DESIRED_CAPACITY
  max_size            = var.ASG_MAX_CAPACITY
  min_size            = var.ASG_MIN_CAPACITY

  launch_template {
    id      = aws_launch_template.ec2-tpl.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

