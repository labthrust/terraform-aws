# Modified by AppThrust on Wed Sep 18 2024 13:29:31 GMT+0900
# Original code from https://github.com/aws-ia/terraform-aws-eks-blueprints/blob/6409db6dc76943a000a7e055b3e0215e11aa0bbf/patterns/karpenter/main.tf
# Licensed under Apache License 2.0.

variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "name" {
  type    = string
  default = "eks-karpenter-fargate"
}
