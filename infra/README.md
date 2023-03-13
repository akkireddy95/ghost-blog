# Repository for the AWS IaC in Terraform.

Creates the initial Ghost-Blog infrastructure, containing one VPC with 2 private and 2 public networks for HA setup. This setup also contains IaC for ECS deployment with a task, RDS resource and EC2 resources.

The deployment also contains AWS ECR to store the docker images for the builds of the microservices.

All of this is separated into 2 different environemnets, dev and prod. dev should be almost identical to prod.


## Usage

For first time use, run 'terraform init' inside the respective environment folder.

Run 'terraform plan' to check the changes and 'terraform apply' inside the respective environment folder to apply the changes. You will need to correctly enter the database password value every time you run these commands.

Every type of resource is separated in a different terraform file. The numbers in front of the yml files are usually there to show the order in which everything should be deployed even though Terraform is smart enough to know this.

The variables are defined in variables.tf but the input of their values is done in terraform.tfvars

## Architecture

A new VPC is created for this environment with 4 subnets, 2 private and 2 public for high avalability. The EKS cluster and its nodes are deployed inside the private networks for security and they have internet access through a NAT gateway.

The RDS instance that is used to host the application databases is in the private networks as well for security.

### Terraform structure
.
├── 00-provider.tf -- Configure the AWS provider and any necessary plugins.
├── 01-vpc.tf
├── 02-sg.tf
├── 03-ec2.tf
├── 04-alb.tf
├── 05-ecs.tf
├── 06-rds.tf
├── 07-ecr.tf
├── 08-efs.tf
├── 09-s3.tf
├── 10-route53.tf
├── 11-waf.tf
├── 12-cloudwatch.tf
├── output.tf
├── variables.tf
└── terraform.tfvars

## Local setup - Pass through the Terraform stages
Use "terraform init" to initialize a working directory containing terraform config files. 
After successful initiation, use "terraform plan" to let you preview the changes the terraform plans to make to your infrastructure. What it does by default is:
        * Reads the current state of any already-existing remote objects to make sure that the Terraform state is up-to-date.
        * Compares the current configuration to the prior state and noting any differences.
        * Proposes a set of change actions that should, if applied, make the remote objects match the configuration.

Only if required - create "terraform apply" and  to destroy "terraform destroy" commands.

export aws environment variables.

```bash

terraform init

terraform validate

terraform plan

terraform apply --auto-approve
```