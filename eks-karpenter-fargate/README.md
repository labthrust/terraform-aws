<!--
Modified by [Your Name or Your Project Name] on [Date].
Original file sourced from https://github.com/aws-ia/terraform-aws-eks-blueprints/blob/6409db6dc76943a000a7e055b3e0215e11aa0bbf/patterns/karpenter/README.md
Licensed under Apache License 2.0.
-->

# Karpenter on EKS Fargate

This pattern demonstrates how to provision Karpenter on a serverless cluster (serverless data plane) using Fargate Profiles.

## Deploy

See [here](https://aws-ia.github.io/terraform-aws-eks-blueprints/getting-started/#prerequisites) for the prerequisites and steps to deploy this pattern.

## Validate

1. Test by listing the nodes in the cluster. You should see four Fargate nodes in the cluster:

    ```sh
    kubectl get nodes

    NAME                                                STATUS   ROLES    AGE     VERSION
    fargate-ip-10-0-11-195.us-west-2.compute.internal   Ready    <none>   5m20s   v1.28.2-eks-f8587cb
    fargate-ip-10-0-27-183.us-west-2.compute.internal   Ready    <none>   5m2s    v1.28.2-eks-f8587cb
    fargate-ip-10-0-4-169.us-west-2.compute.internal    Ready    <none>   5m3s    v1.28.2-eks-f8587cb
    fargate-ip-10-0-44-106.us-west-2.compute.internal   Ready    <none>   5m12s   v1.28.2-eks-f8587cb
    ```

2. Before applying the Karpenter resources, you need to create the AWS Spot service-linked role. Run the following command:

    ```sh
    aws iam create-service-linked-role --aws-service-name spot.amazonaws.com
    ```

   This step is necessary to allow Karpenter to launch and manage Spot Instances.

3. Provision the Karpenter `EC2NodeClass` and `NodePool` resources which provide Karpenter the necessary configurations to provision EC2 resources:

    ```sh
    kubectl apply -f karpenter.yaml
    ```

4. Once the Karpenter resources are in place, Karpenter will provision the necessary EC2 resources to satisfy any pending pods in the scheduler's queue. You can demonstrate this with the example deployment provided. First deploy the example deployment which has the initial number replicas set to 0:

    ```sh
    kubectl apply -f example.yaml
    ```

5. When you scale the example deployment, you should see Karpenter respond by quickly provisioning EC2 resources to satisfy those pending pod requests:

    ```sh
    kubectl scale deployment inflate --replicas=3
    ```

6. Listing the nodes should now show some EC2 compute that Karpenter has created for the example deployment:

    ```sh
    kubectl get nodes

    NAME                                                STATUS   ROLES    AGE   VERSION
    fargate-ip-10-0-11-195.us-west-2.compute.internal   Ready    <none>   13m   v1.28.2-eks-f8587cb
    fargate-ip-10-0-27-183.us-west-2.compute.internal   Ready    <none>   12m   v1.28.2-eks-f8587cb
    fargate-ip-10-0-4-169.us-west-2.compute.internal    Ready    <none>   12m   v1.28.2-eks-f8587cb
    fargate-ip-10-0-44-106.us-west-2.compute.internal   Ready    <none>   13m   v1.28.2-eks-f8587cb
    ip-10-0-32-199.us-west-2.compute.internal           Ready    <none>   29s   v1.28.2-eks-a5df82a # <== EC2 created by Karpenter
    ```

## Destroy

Scale down the deployment to de-provision Karpenter created resources first:

```sh
kubectl delete -f example.yaml
```

{%
   include-markdown "../../docs/_partials/destroy.md"
%}
