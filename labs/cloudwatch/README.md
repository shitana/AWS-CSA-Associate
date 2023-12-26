

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [Terraform EC2 and CloudWatch Lab](#terraform-ec2-and-cloudwatch-lab)
  - [Project Overview](#project-overview)
  - [Files Description](#files-description)
  - [Usage Instructions](#usage-instructions)
  - [Additional Information](#additional-information)

<!-- /code_chunk_output -->

# Terraform EC2 and CloudWatch Lab

## Project Overview

This lab demonstrates how to use Terraform to set up AWS EC2 instances and configure them for monitoring with CloudWatch. It includes the creation of necessary IAM roles, policies, security groups, and the installation and configuration of the CloudWatch Agent on the EC2 instances.

## Files Description

- `variables.tf`: This file declares variables to be used across the Terraform configuration, allowing for a dynamic and customizable setup.
- `backend.tf`: Configures the backend for Terraform, which is essential for state management in collaborative environments.
- `data.tf`: Contains definitions for data sources that Terraform uses to fetch information about existing infrastructure or external data.
- `ec2_instances.tf`: Defines the properties and configurations of AWS EC2 instances.
- `iam_role.tf`: Sets up IAM roles, specifying permissions and creating a secure AWS environment.
- `instance_profile.tf`: Associates IAM roles with EC2 instances through instance profiles.
- `provider.tf`: Specifies the Terraform provider (e.g., AWS) and any necessary configurations such as region.
- `role_policy_attachment.tf`: Manages the attachment of policies to IAM roles.
- `sg.tf`: Defines security groups and rules to control inbound and outbound traffic to AWS resources.

## Usage Instructions

To use this Terraform configuration:

1. Ensure you have Terraform installed on your machine.
2. Configure your AWS credentials. (<https://github.com/shitana/aws-tools/blob/main/aws_sso_export.py>)
3. Customize the variables in `variables.tf` as per your requirements.
4. Initialize the Terraform project by running `terraform init`.
5. Apply the configuration using `terraform apply`.

## Additional Information

This project is modular and can be adjusted as needed. It is recommended to review and test each component in a staging environment before deploying to production.