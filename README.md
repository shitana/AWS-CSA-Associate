# Course details

- [AWS Certified SysOps Admin - Associate (SOA-C02)](https://app.pluralsight.com/library/courses/aws-certified-sysops-admin---associate/exercise-files)
- [Course Resources](https://github.com/ACloudGuru-Resources/course-aws-sysops-administrator-associate/tree/main)

# Section 3 : Deployment, Provisioning, and Automation

## Elastic Block Store (EBS)

### Notes

- Highly Available / Duplicated within an Availability Zone
- Type :
  - General Pupose SSD GP2 / GP3 up to 16000 IOPS
  - Provisioned IOPS SSD IO1 / IO2 : High perf needs up to 64000 IOPS
  - IO2 Block Express 
  - Optimized HDD ST1 : designed for long term storage
  - Cold HDD SC1 : lowest cost 

[Understanding EBS Volumes, Amazon EBS volume types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html)

### Exam Tips

- EBS SSD 
  - GP2 / GP3 
    - Up to 16000 IOPS
    - Boot disks / general applications
  - IO1 / IO2 
    - Up to 64 000 IOPS
    - Up to 500 IOPS per GiB (50 for io1)
    - OLTP online Transaction processing / Latency sensitive
  - IO2 Block Express (SAN on cloud)
    - Up to 64 TB, 256000 IOPS
    - Large / critical, HP app (SAP HANA, Oracle, DB Server )
- EBS HDD
  - ST1 (not bootable)
    - Throuput optimized for Big Data, Data Warehouse, ...
    - Up to 500 MB /s
  - SC1 (not bootable)
    - Max throuput 250 MB / S
    - Less frequently accessed data

## Bastion

- A secure entry point to my infra
![Simple arch](img/bastion_archi.png)
- Bastion is an instance created on a public subnet with a public IP
- Private instance is in a praivate subnet
- we need to securitygroup
  - Bastion : enable public access on SSH to bastion
  - **Private : enable ssh connection only from bastion**
- Internet Gateway and RouteTable needed route traffic in/out to bastion

## Elastic Load Balancer (ELB)

### Types

- Application Load Balancer : HTTP / HTTPS : Layer 7
- Network load balancer :  TCP High Perf : Layer 4 
- Classic load balancer : HTTP/HTTPS/TCP (Legacy option)
- Gateway Load Balancer :
  - Load balance workloads for third-party virtual appliances running on AWS (virt FW, IDS, IPS, ...)
![7 Layer](img/7_layer.png)

### Application Load Balancer

- we can lanipulate X-Forwarded-For Header to identify original IP

### ELB Error Messages

- Client Side : Error 4XX
  - HTTP 400 : Bad request
  - HTTP 408 : Request Timeout
  - HTTP 464 : using unsuported protocol
- Server Side : Error 5XX
  - HTTP 504 : Gateway Timeout
  - HTTP 502 : Target host unreachable
  - HTTP 503 : No registred targets

![Alt text](img/error_message_elb.png)

> ***CLOUDWATCH***
> 