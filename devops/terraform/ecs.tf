resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.PROJECT_NAME}-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}


# add the autoscaling group as a capacity provider
resource "aws_ecs_capacity_provider" "ecs-asg-capacity-provider" {
  name = var.ASG_CAPACITY_PROVIDER_NAME

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs_asg.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = 1000
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 3
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "ecs-cluster-capacity-provider" {
  cluster_name = aws_ecs_cluster.ecs-cluster.name

  capacity_providers = [aws_ecs_capacity_provider.ecs-asg-capacity-provider.name]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.ecs-asg-capacity-provider.name
  }
}

# task definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family             = "${var.PROJECT_NAME}-family"
  network_mode       = "awsvpc"
  execution_role_arn = var.EXECUTION_ROLE_ARN
  cpu                = var.ECS_TASK_CPU
  runtime_platform {
    operating_system_family = var.ECS_TASK_OS_FAMILY
    cpu_architecture        = var.ECS_TASK_CPU_ARCHITECTURE
  }
  #  automate the container definition
  container_definitions = jsonencode([
    {
      name      = "nginx-demo"
      image     = "nginxdemos/hello"
      cpu       = 2048
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

# service definition
resource "aws_ecs_service" "ecs_service" {
  name            = "${var.PROJECT_NAME}-ecs-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 2

  network_configuration {
    subnets         = data.aws_subnets.available_subnets.ids
    security_groups = [aws_security_group.app_sg.id]
  }

  force_new_deployment = true
  placement_constraints {
    type = "distinctInstance"
  }

  triggers = {
    redeployment = timestamp()
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs-asg-capacity-provider.name
    weight            = 100
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg-ec2.arn
    container_name   = "nginx-demo"
    container_port   = 80
  }

  depends_on = [aws_autoscaling_group.ecs_asg]
}

