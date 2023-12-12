
# AWS EC2 Instance Creation Using CloudFormation

This README outlines the steps to use a CloudFormation template for creating an EC2 instance in AWS and how to connect to it using SSH.

## Prerequisites

- AWS CLI installed and configured with appropriate permissions.
- An SSH key pair named `mysshkey` already created in the AWS region where you are deploying the stack.
- The private key corresponding to `mysshkey` should be saved as `~/.ssh/aws_mysshkey` on your local machine.

## Using the CloudFormation Template

### Step 1: Deploy the CloudFormation Stack

1. **Save the Template**: Save the provided CloudFormation template in a file named `ec2_template.yaml`.

2. **Deploy the Stack**:
   ```bash
   aws cloudformation create-stack --stack-name MyEC2Stack --template-body file://ec2_template.yaml --parameters ParameterKey=KeyName,ParameterValue=mysshkey
   ```
   Replace `MyEC2Stack` with a unique name for your CloudFormation stack.

3. **Monitor the Stack Creation**:
   ```bash
   aws cloudformation describe-stacks --stack-name MyEC2Stack
   ```
   This command checks the status of the stack.

### Step 2: Retrieve the Output

Once the stack creation is complete, retrieve the EC2 instance's Public IP Address or DNS name:

```bash
aws ec2 describe-instances --filters "Name=tag:Name,Values=My CF Instance" --query "Reservations[*].Instances[*].[PublicIpAddress, PublicDnsName]"
```

## Connecting to the EC2 Instance

### SSH Connection

Use the following command to connect to your EC2 instance:

```bash
ssh -i ~/.ssh/aws_mysshkey ec2-user@<PublicIpAddress_or_PublicDnsName>
```

Replace `<PublicIpAddress_or_PublicDnsName>` with the actual public IP address or DNS name of your instance.

## Important Notes

- Ensure that the file `~/.ssh/aws_mysshkey` has the correct permissions set (read-only for the user). You can set this with the command `chmod 400 ~/.ssh/aws_mysshkey`.
- The user name for the SSH connection depends on the AMI used.
  - For Amazon , it's typically `ec2-user`.
  - For Ubuntu , it's typically `ubuntu`.

## Delete Stack

```bash
aws cloudformation delete-stack --stack-name MyEC2Stack
```