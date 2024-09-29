# pedeai-k8s

Repository to provision Kubernetes cluster in AWS EKS (Elastic Kubernetes Service) using Terraform.

### Terraform modules

- **eks**: EKS cluster.
- **network**: VPCs, internet gateway, subnets, elastic IPs, NAT gateway, route tables and table associations.
- **nodes**: managed node group.

### How to use

#### Github Actions

- Configure the repository secrets.
- Go to actions and manually run **Provision k8s Cluster and Ingress/LB** Github Action.

#### Locally

With **terraform** and **aws CLI** installed.

Configure aws credentials:

- edit `~/.aws/credentials` file

To create EKS cluster:

- `terraform init` to initialize
- `terraform plan` to plan the deploy
- `terraform apply` to create resources

To install Nginx Ingress and Load Balancer:

- `aws eks update-kubeconfig --name fiap44-eks-cluster --region us-east-1` to configure kubectl
- `curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash` to install Helm
- ```bash
  # to install nginx ingress execute:
  helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx && \
  helm upgrade -i --set controller.service.type=LoadBalancer \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-type"="nlb" \
  --set controller.autoscaling.maxReplicas=1 ingress-nginx ingress-nginx/ingress-nginx \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-internal"="true"
  ```

To destroy:

- `terraform destroy` to destroy resources
