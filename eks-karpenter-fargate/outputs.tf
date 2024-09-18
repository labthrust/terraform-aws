# Modified by AppThrust on Wed Sep 18 2024 13:29:31 GMT+0900
# Original code from https://github.com/aws-ia/terraform-aws-eks-blueprints/blob/6409db6dc76943a000a7e055b3e0215e11aa0bbf/patterns/karpenter/outputs.tf
# Licensed under Apache License 2.0.

output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = "aws eks --region ${var.region} update-kubeconfig --name ${module.eks.cluster_name}"
}
