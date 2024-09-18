# Modified by AppThrust on Wed Sep 18 2024 13:29:31 GMT+0900
# Original code from https://github.com/aws-ia/terraform-aws-eks-blueprints/blob/6409db6dc76943a000a7e055b3e0215e11aa0bbf/patterns/karpenter/versions.tf
# Licensed under Apache License 2.0.

terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.67"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.15"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.32"
    }
  }
}
