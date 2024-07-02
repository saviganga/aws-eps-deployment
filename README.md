# aws-ecs-deployment

Create an ecs cluster
1. EC2 launch type
2. Fargate launch type

1. EC2 Launch type
- get your vpc and subnet data
- launch an ALB (provision security group)
- create a launch template (provision security group, key pairs)
- provision an autoscaling group to launch/manage ec2 instances
- provision ecs cluster (capacity providers)
