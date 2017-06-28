# terraform-ecs-cluster

This repo contains a [Terraform](https://terraform.io/) module to create an Amazon ECS Cluster.

* Creates the cluster
* Creates n-instances and attach them to the cluster
* Create the required IAM roles, required for ECS Services.


Module usage:

      provider "aws" {
        access_key = "${var.access_key}"
        secret_key = "${var.secret_key}"
        region     = "us-east-1"
      }

    module "ecs-cluster" {
        source                = "github.com/grey-systems/terraform-ecs-cluster.git?ref=master"
        environment           = "${var.environment}"
        name                  = "cluster-name"
        instance_keypair_name = "${var.keypair_name}"

        # use github.com/grey-systems/terraform-multitier-vpc to create the VPC and the subnetsOB
        vpc_subnet_ids        = ["${split(",", module.vpc_network.private_subnets_ids)}"]
        instances             = ["${var.ecs_instances}"]
    }


Inputs
---------

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allowed_subnets |  List of subnets that can access (all traffic) the ecs cluster instances. Intended for VPN/HQ/Devops networks to troubleshoot/testing the cluster directly  | list | `<list>` | no |
| environment |  Environment name. Used to name resources, so that you can use this same module for several environments. All resources will be named as {name}-{environment}  | string | - | yes |
| instance_keypair_name |  keypair name for the cluster node's instances  | string | - | yes |
| instances |   * List of instances defined by its type.  * The default value will create 2x t2.small instances + 1x t2.medium instance   | list | `<list>` | no |
| name |  Name of the ecs cluster  | string | - | yes |
| vpc_subnet_ids |  List of vpc subnets to spare the different nodes of the cluster  | list | - | yes |

Outputs
----------

| Name | Description |
|------|-------------|
| ecs_service_role_arn |  Arn of the service role created for this cluster, required for ECS services|
| id | AWS id of the ECS Cluster |
| name | Name of the cluster, note that this name is the concatenation of the environment + the name given as input |


Contributing
------------
Everybody is welcome to contribute. Please, see [`CONTRIBUTING`][contrib] for further information.

[contrib]: CONTRIBUTING.md

Bug Reports
-----------

Bug reports can be sent directly to authors and/or using github's issues.


-------

Copyright (c) 2017 Grey Systems ([www.greysystems.eu](http://www.greysystems.eu))

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
