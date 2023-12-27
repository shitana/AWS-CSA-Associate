
- [High-Availability Web Server with ALB using Terraform](#high-availability-web-server-with-alb-using-terraform)
  - [Project Overview](#project-overview)
  - [Files Description](#files-description)
  - [Usage Instructions](#usage-instructions)
  - [Note](#note)

# High-Availability Web Server with ALB using Terraform

## Project Overview

This Terraform project automates the deployment of a high-availability web server environment on AWS. It involves setting up two EC2 instances with a pre-configured web server and an Application Load Balancer (ALB) to manage traffic between these instances.

## Files Description

- `provider.tf`: Configures the AWS provider and specifies the AWS region (`eu-west-3`).
- `backend.tf`: Sets up an S3 backend for Terraform state management, ensuring consistent state tracking across team members.
- `data.tf`: Fetches data from AWS, including the latest Amazon Linux AMI and details of the default VPC and its subnets.
- `variables.tf`: Declares variables like AWS region and instance count, providing flexibility and scalability.
- `sg.tf`: Defines security groups for both the ALB and the EC2 instances, ensuring secure network traffic management.
- `alb.tf`: Creates the Application Load Balancer, target group, and listener setup for directing traffic to the EC2 instances.
- `ec2_instances.tf`: Deploys EC2 instances with user data to install and start a web server, serving a simple HTML page.

## Usage Instructions

1. **Prerequisites**: Ensure you have Terraform and AWS CLI installed and configured.
2. **Clone the Repository**: Clone this repository to get all the Terraform files.
3. **Initialize Terraform**: Run `terraform init` in the directory where the files are located.
4. **Customize Variables**: Modify `variables.tf` as needed (e.g., instance count, region).
5. **Apply Configuration**: Execute `terraform apply` to create the AWS resources.
6. **Access the Web Server**: Once deployed, access the web server through the ALB's DNS name.

## Note

- Always test in a staging environment before applying changes in production.
- Review and adjust security group rules according to your security policies.