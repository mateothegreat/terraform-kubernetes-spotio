variable "spotinst_token" {

    type        = string
    description = "Spotinst Personal Access token"

}

variable "spotinst_account" {

    type        = string
    description = "Spotinst account ID"

}

variable "cluster_name" {

    type        = string
    description = "Cluster name"

}

variable "cluster_version" {

    type        = string
    description = "Kubernetes supported version"
    default     = "1.22"

}

variable "region" {

    type        = string
    description = "The region the EKS cluster will be located"
    default     = "us-east-1"

}

variable "ami_id" {

    type        = string
    description = "The image ID for the EKS worker nodes. If none is provided, Terraform will search for the latest version of their EKS optimized worker AMI based on platform"

}

variable "min_size" {

    type        = number
    description = "The lower limit of worker nodes the Ocean cluster can scale down to"

}

variable "max_size" {

    type        = number
    description = "The upper limit of worker nodes the Ocean cluster can scale up to"

}

variable "desired_capacity" {

    type        = number
    description = "The number of worker nodes to launch and maintain in the Ocean cluster"

}

variable "key_name" {

    type        = string
    description = "The key pair to attach to the worker nodes launched by Ocean"
    default     = null

}

variable "associate_public_ip_address" {

    type        = bool
    description = "Associate a public IP address to worker nodes"
    default     = false

}

variable "private_subnets" {

    type        = list(string)
    description = "cidr ranges for the private subnets"

}

variable "tags" {

    description = "ec2 tags"
    default     = {}

}

variable "spot_subscription_events" {

    type    = list(string)
    default = [

        "AWS_EC2_INSTANCE_TERMINATE",
        "AWS_EC2_INSTANCE_TERMINATED",
        "AWS_EC2_INSTANCE_LAUNCH",
        "AWS_EC2_INSTANCE_READY_SIGNAL_TIMEOUT",
        "AWS_EC2_CANT_SPIN_OD",
        "AWS_EC2_INSTANCE_UNHEALTHY_IN_ELB",
        "GROUP_ROLL_FAILED",
        "GROUP_ROLL_FINISHED",
        "CANT_SCALE_UP_GROUP_MAX_CAPACITY",
        "GROUP_UPDATED",
        "AWS_EMR_PROVISION_TIMEOUT",
        "GROUP_BEANSTALK_INIT_READY",
        "CLUSTER_ROLL_FINISHED",
        "GROUP_ROLL_FAILED"

    ]

}

variable "notification_sqs_arn" {

    type        = string
    description = "aws sqs arn for event subscriptions"
    default     = null

}

variable "launch_specs" {

    description = "launch specs for node groups"

    type = list(object({

        name               = string
        image_id           = string
        root_volume_size   = number
        max_instance_count = number
        instance_types     = list(string)
        spot_percentage    = number
        tags               = map(string)
        labels             = map(string)

        #
        # See https://registry.terraform.io/providers/spotinst/spotinst/latest/docs/resources/ocean_aws_launch_spec#autoscale_headrooms
        #
        autoscale_headrooms = object({

            num_of_units    = number
            cpu_per_unit    = number
            gpu_per_unit    = number
            memory_per_unit = number

        })

    }))

}

variable "cluster_endpoint_private_access" {

    type        = bool
    description = "enable private access to the kubernetes api endpoint"
    default     = true

}

variable "cluster_endpoint_public_access" {

    type        = bool
    description = "enable private access to the kubernetes api endpoint"
    default     = true

}

variable "max_scale_down_percentage" {

    type        = number
    description = "maximum percent to scale down in a period"
    default     = 90

}

variable "additional_security_group" {

    type        = string
    description = "additional security group to assign to worker nodes"
    default     = null

}

variable "controller_node_selector" {

    type        = map(string)
    description = "node_selector for the ocean controller pod"
    default     = {}

}

variable "instance_types_blacklist_gpu" {

    type        = list(string)
    description = "types to blacklist for GPU instance types"

    default = [

        "g4ad.16xlarge",
        "g4ad.4xlarge",
        "g4ad.8xlarge",

        "g4dn.8xlarge",
        "g4dn.16xlarge",
        "p3.2xlarge"

    ]

}

variable "map_users" {

    description = "Additional IAM users to add to the aws-auth configmap. See examples/basic/variables.tf for example format."

    type = list(object({
        userarn  = string
        username = string
        groups   = list(string)
    }))

    default = [ ]

}

variable "roll_all_nodes_on_change" {

    description = "whether or not to re-schedule all nodes when the configuration changes"
    type        = bool
    default     = false

}

variable "base_url" {

    type        = string
    description = "Base URL to be used by the HTTP client"
    default     = ""

}

variable "proxy_url" {

    type        = string
    description = "Proxy server URL to communicate through"
    default     = ""

}

variable "enable_csr_approval" {
    type        = bool
    description = "Enable the CSR approval feature"
    default     = false
}

variable "disable_auto_update" {
    type        = bool
    description = "Disable the auto-update feature"
    default     = false
}

variable "security_groups" {

    type = list(string)

}

variable "iam_instance_profile" {

    type = string

}
