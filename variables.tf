/* Name of the ecs cluster */
variable "name" {
  type = "string"
}

/*
 * List of instances defined by its type.
 * The default value will create 2x t2.small instances + 1x t2.medium instance
 */
variable "instances" {
  type = "list"
  default = ["t2.medium","t2.small", "t2.small"]
}

/* keypair name for the cluster node's instances */
variable "instance_keypair_name" {
  type = "string"
}

/* List of vpc subnets to spare the different nodes of the cluster */
variable "vpc_subnet_ids" {
  type = "list"
}

/* Environment name. Used to name resources, so that you can use this same module for several environments. All resources will be named as {name}-{environment} */
variable "environment" {
  type = "string"
}

/* Defines if the creation of a route52 zone for the ecs cluster will be required. This zone can be used for a simple and easy service discovery mechanism */
variable "create_route53zone" {
  type    = "string"
  default = "1"
}

/* List of subnets that can access (all traffic) the ecs cluster instances.
* Intended for VPN/HQ/Devops networks to troubleshoot/testing the cluster directly
*/
variable "allowed_subnets" {
  type = "list"
  default = []
}
