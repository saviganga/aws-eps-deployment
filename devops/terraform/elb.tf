# create an application load balancer resource
resource "aws_lb" "lb" {
  name               = "${var.PROJECT_NAME}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = data.aws_subnets.available_subnets.ids

  enable_deletion_protection = false

  tags = {
    Name = "${var.PROJECT_NAME}-lb"
  }
}

# create a target group for the load balancer
resource "aws_lb_target_group" "tg-ec2" {
  name        = "${var.PROJECT_NAME}-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = data.aws_vpcs.current_vpcs.ids[0]
  target_type = "instance"

}

# Create an ALB listener to handle load balancer redirect - check what the module 'listener_rules' does
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 3000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-ec2.arn
  }
}

output "elb-dns" {
  value = aws_lb.lb.dns_name
}