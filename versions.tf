terraform {

    required_providers {

        kubernetes = {

            source = "hashicorp/kubernetes"

        }

        spotinst = {

            source = "spotinst/spotinst"

        }

    }

    required_version = ">= 0.13"

}
