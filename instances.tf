#Security groups

resource "aws_security_group" "ecs-security-group" {
  name        = "${aws_ecs_cluster.ecs_cluster.name}_ecs_secgroup"
  description = "[${var.environment}] security group for ECS instances"
  vpc_id      = "${data.aws_vpc.vpc.id}"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    #provisional: Change it to be parametrizable
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    #provisional: Change it to be parametrizable
    cidr_blocks = ["${concat(data.aws_vpc.vpc.*.cidr_block,var.allowed_subnets)}"]
  }

  tags {
    Name = "${aws_ecs_cluster.ecs_cluster.name}_ecs_secgroup"
    Env  = "${var.environment}"
  }
}

# Instance definitions

resource "aws_instance" "ecs-instance" {
  ami                    = "${data.aws_ami.ecs_ami.image_id}"
  subnet_id              = "${element(var.vpc_subnet_ids, count.index % length(var.vpc_subnet_ids))}"
  count                  = "${length(var.instances)}"
  instance_type          = "${element(var.instances, count.index)}"
  key_name               = "${var.instance_keypair_name}"
  vpc_security_group_ids = ["${aws_security_group.ecs-security-group.id}"]

  tags {
    Name = "[${aws_ecs_cluster.ecs_cluster.name}] instance-${count.index}"
  }

  user_data = <<EOF
#!/bin/bash
sudo yum update -y
echo ECS_CLUSTER=${aws_ecs_cluster.ecs_cluster.name} >> /etc/ecs/ecs.config
sudo reboot
EOF

  iam_instance_profile = "${aws_iam_instance_profile.ecs_instance_iam_profile.name}"
}
