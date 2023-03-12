# Repository for the AWS IaC in Terraform.

Creates the initial Ghost-Blog infrastructure, containing one VPC with 2 private and 2 public networks for HA setup. This setup also contains IaC for ECS deployment with a task, RDS resource and EC2 resources.

The deployment also contains AWS ECR to store the docker images for the builds of the microservices.

All of this is separated into 3 different environemnets, dev, stag and prod. Staging should be almost identical to prod.

Terraform state is locked by DynamoDB remotley on an S3 bucket, meaning anyone can work with this terraform code without having to worry about the state and if someone else is trying to apply changes (no risk of conflicting two infra deployments at the same time).

## Deployment

Before deploying the infra, cd to the remote-state folder and run 'terraform init' and 'terraform apply' to create the S3 bucket and DynamoDB table that will be used to save the tfstate remotely.

Back in the enviorment folder, run terraform init to intiate the S3 backend.

The only manual thing that needs to be done before running apply is to create an EC2 keypair:
1. Create it in the console, use the same name from the variable ssh_keypair, in EC2 and save it.
2. Extract the public key from the pem file.
3. Insert it in terraform.tfvars under the public_key parameter.
4. Import the resource in terraform with the command:
$ terraform import aws_key_pair.ssh_keypair <name of the key>
5. Download the terraform.tf state from the S3 bucket, add the public key in the public_key value inside. Upload and overwrite the file back on the S3 bucket.
6. This might cause the DynamoDB table to break so delete the table manually, go to the remote-state folder again, run 'terraform init' and 'terraform apply' to rebuild the remote state.

You can use this procedure for adding any new ssh keypairs in Terraform.

## Usage

For first time use, run 'terraform init' inside the respective environment folder.

Run 'terraform plan' to check the changes and 'terraform apply' inside the respective environment folder to apply the changes. You will need to correctly enter the database password value every time you run these commands.

Every type of resource is separated in a different terraform file. The numbers in front of the yml files are usually there to show the order in which everything should be deployed even though Terraform is smart enough to know this.

The variables are defined in variables.tf but the input of their values is done in terraform.tfvars

## Architecture

A new VPC is created for this environment with 4 subnets, 2 private and 2 public for high avalability. The EKS cluster and its nodes are deployed inside the private networks for security and they have internet access through a NAT gateway.

The Jenkins and Nexus instances are deployed in the public networks and have elastic IPs but their access is strictly restricted by the security groups.

The RDS instance that is used to host the application databases is in the private networks as well for security.

# To create infrastructure in terraform, CD into terraform and run,

Using Terraform to create an environment-

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

terraform plan

terraform apply --auto-approve
```



order for creating Terraform resources based on the provided files:

provider.tf - Configure the AWS provider and any necessary plugins.
vpc.tf - Create the Virtual Private Cloud (VPC) and related resources, such as subnets, route tables, and internet gateways.
sg.tf - Define any security groups required for your infrastructure, such as those for EC2 instances or ALBs.
ec2.tf - Create any EC2 instances and related resources, such as key pairs or instance profiles.
alb.tf - Create any Application Load Balancers (ALBs) or Network Load Balancers (NLBs) needed for your application.
ecs.tf - Define your ECS cluster, services, and tasks. This may include creating task definitions, service definitions, and configuring load balancing.
rds.tf - Create any RDS instances or Aurora clusters required for your application.
ecr.tf - Define your Elastic Container Registry (ECR) repositories for storing container images.
efs.tf - Create any Elastic File System (EFS) instances needed for your application.
s3.tf - Define any S3 buckets required for storing application artifacts or static files.
route53.tf - Configure any necessary DNS records for your infrastructure.
waf.tf - Create Web Application Firewall (WAF) rules to protect your infrastructure from malicious traffic.
cloudwatch.tf - Configure any necessary CloudWatch metrics, logs, or alarms for monitoring your infrastructure.
iam.tf - Define any IAM roles, policies, or users required for your infrastructure.
variables.tf - Define any variables used throughout your Terraform configuration.
terraform.tfvars - Set values for your Terraform variables.
output.tf - Define any output values you want to expose from your Terraform configuration.
Note that the order of these files may vary depending on your specific application and infrastructure needs. Additionally, you may have multiple files for each type of resource if your infrastructure is complex.




Akkireddy Challa
How can optimise above  infrastructure
There are several ways to optimize the infrastructure created using Terraform. Here are a few suggestions:

Use variables: Define variables for resources that will be reused throughout the code. This reduces redundancy and makes it easier to manage the resources.

Use modules: Break down the infrastructure into reusable modules. Modules can be used to organize resources and make them more modular, easier to understand, and easier to manage.

Use Terraform state: Store the Terraform state in a remote backend like Amazon S3 or Consul to keep the state file centralized and avoid state drift.

Use Terraform Cloud: Consider using Terraform Cloud for collaboration and version control. This is a cloud-based platform that provides a centralized location for managing Terraform code and state files.

Use Terraform best practices: Follow the best practices recommended by Terraform, such as using meaningful resource names, commenting the code, and separating infrastructure by environment.

Use Terraform linting tools: Use tools like tflint and terraform fmt to catch common errors and ensure the code is well-formatted.

Use Terraform plan and apply: Always run terraform plan before running terraform apply to check for any changes that will be made to the infrastructure.





