# get the vpc fom aws account
data "aws_vpcs" "current_vpcs" {}

# get the subnets in the vpc
data "aws_subnets" "available_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.current_vpcs.ids[0]]
  }
}