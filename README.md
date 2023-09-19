## Overview
This sets up a single node EKS cluster and deploys a highly available app using terraform.

- This is set up in the public subnet and open to reduce cost and allow for ease of implementation
- 
# prerequisite
- aws profile configured

## Step-1: Execute Terraform Commands
```t
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform plan
terraform plan

# Terraform Apply
terraform apply -auto-approve

# Verify Outputs on the CLI or using below command
terraform output
```

## Step-2: Verify the following Services using AWS Management Console
1. Go to Services -> Elastic Kubernetes Service -> Clusters
2. Verify the following
    - Overview
    - Workloads
    - Configuration
        - Details
        - Compute
        - Networking
        - Add-Ons
        - Authentication
        - Logging
        - Update history
        - Tags


## Step-13: Install kubectl CLI
- [Install kubectl CLI](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)

## Step-4: Configure kubeconfig for kubectl
```t
# Configure kubeconfig for kubectl
aws eks --region <region-code> update-kubeconfig --name <cluster_name>
aws eks --region us-east-1 update-kubeconfig --name endy-test-eksdemo

# List Worker Nodes
kubectl get nodes
kubectl get nodes -o wide

# Verify Services
kubectl get svc
```

## Step-5: Connect to EKS Worker Nodes using Bastion Host
```t
# Connect to Bastion EC2 Instance
ssh -i private-key/eks-terraform-key.pem ec2-user@<Bastion-EC2-Instance-Public-IP>
cd /tmp

# Connect to Kubernetes Worker Nodes - Public Node Group
ssh -i private-key/eks-terraform-key.pem ec2-user@<Public-NodeGroup-EC2Instance-PublicIP> 
[or]
ec2-user@<Public-NodeGroup-EC2Instance-PrivateIP>

# Verify if kubelet and kube-proxy running
ps -ef | grep kube

# Verify kubelet-config.json
cat /etc/kubernetes/kubelet/kubelet-config.json

# Verify kubelet kubeconfig
cat /var/lib/kubelet/kubeconfig

```

## Step-6: Verify Namespaces and Resources in Namespaces
```t
# Verify Namespaces
kubectl get namespaces
kubectl get ns 
Observation: 4 namespaces will be listed by default
1. kube-node-lease
2. kube-public
3. default
4. kube-system

# Verify Resources in kube-node-lease namespace
kubectl get all -n kube-node-lease

# Verify Resources in kube-public namespace
kubectl get all -n kube-public

# Verify Resources in default namespace
kubectl get all -n default
Observation: 
1. Kubernetes Service: Cluster IP Service for Kubernetes Endpoint

# Verify Resources in kube-system namespace
kubectl get all -n kube-system
Observation: 
1. Kubernetes Deployment: coredns
2. Kubernetes DaemonSet: aws-node, kube-proxy
3. Kubernetes Service: kube-dns
4. Kubernetes Pods: coredns, aws-node, kube-proxy
```

## Step-7: Verify pods and deployment in the default namespace
```t
# Verify App is running on the loadbalancer service endpoint

