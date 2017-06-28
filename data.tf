data "aws_subnet" "subnet_0" {
  id = "${element(var.vpc_subnet_ids,0)}"
}

data "aws_vpc" "vpc" {
  id = "${data.aws_subnet.subnet_0.vpc_id}"
}

data "aws_ami" "ecs_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*amazon-ecs-optimized*"]
  }

  owners = ["amazon"]
}
