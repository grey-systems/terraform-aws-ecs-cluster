output "name" {
  value = "${aws_ecs_cluster.ecs_cluster.name}"
}

output "id" {
  value = "${aws_ecs_cluster.ecs_cluster.name}"
}

output "ecs_service_role_arn" {
  value = "${aws_iam_role.ecs_service_role.arn}"
}
