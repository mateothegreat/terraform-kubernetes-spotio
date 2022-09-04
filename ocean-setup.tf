resource "spotinst_ocean_aws" "this" {

    name                        = var.cluster_name
    controller_id               = var.cluster_name
    region                      = var.region
    max_size                    = var.max_size
    min_size                    = var.min_size
    desired_capacity            = var.desired_capacity
    subnet_ids                  = var.private_subnets
    image_id                    = var.ami_id
    security_groups             = var.security_groups
    key_name                    = var.key_name
    associate_public_ip_address = var.associate_public_ip_address
    iam_instance_profile        = var.iam_instance_profile
    blacklist                   = var.instance_types_blacklist_gpu

    user_data = <<-EOF
        #!/bin/bash
        set -o xtrace
        /etc/eks/bootstrap.sh ${var.cluster_name}
    EOF

    update_policy {

        should_roll = var.roll_all_nodes_on_change

        roll_config {

            batch_size_percentage = 10

        }

    }

    tags {

        key   = "Name"
        value = "${var.cluster_name}-ocean-cluster-node"

    }

    tags {

        key   = "kubernetes.io/cluster/${var.cluster_name}"
        value = "owned"

    }

    autoscaler {

        autoscale_is_enabled     = true
        autoscale_is_auto_config = true

        autoscale_down {

            max_scale_down_percentage = var.max_scale_down_percentage

        }

    }

    lifecycle {

        ignore_changes = [

            desired_capacity

        ]

    }

}
