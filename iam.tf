resource "aws_iam_role" "ecs_service_role" {
    name = "${aws_ecs_cluster.ecs_cluster.name}_${var.environment}_ecsServiceRole"
    assume_role_policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "ecs.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
}
EOF
}

resource "aws_iam_role" "ecs_instance_role" {
    name = "${aws_ecs_cluster.ecs_cluster.name}_${var.environment}_ecsInstanceRole"
    assume_role_policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid":"",
        "Effect":"Allow",
        "Principal":{
          "Service":"ec2.amazonaws.com"
        },
        "Action":"sts:AssumeRole"
      }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "ecs_instance_iam_profile" {
    name = "${aws_ecs_cluster.ecs_cluster.name}_ecs-instance-iam-profile"
    role = "${aws_iam_role.ecs_instance_role.name}"
}

resource "aws_iam_role_policy_attachment" "ecs_service_role_attachment" {
    role = "${aws_iam_role.ecs_service_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_attachment" {
    role = "${aws_iam_role.ecs_instance_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
