# pedeai-k8s

Repository to provision Kubernetes cluster in AWS EKS (Elastic Kubernetes Service) using Terraform.

### Terraform modules

- **eks**: EKS cluster.
- **network**: VPCs, internet gateway, subnets, elastic IPs, NAT gateway, route tables, table associations.
- **nodes**: managed node group.

### How to use

With *terraform* and *aws CLI* installed.

To create:

- `terraform init` to initialize
- `terraform plan` to plan deploy
- `terraform apply` to create resources

To destroy:

- `terraform destroy` to destroy resources