- [Region, AZ, Edge Locations](#region-az-edge-locations)
- [Key Services for the Exam](#key-services-for-the-exam)
- [AWS Well Architecture Framework](#aws-well-architecture-framework)
- [IAM](#iam)
  - [Root account:](#root-account)
    - [Secure AWS Root Account](#secure-aws-root-account)
    - [Policy](#policy)
  - [Perm IAM credentials](#perm-iam-credentials)
- [S3](#s3)
  - [S3 Basics](#s3-basics)
  - [S3 Standard](#s3-standard)
  - [S3 characteristics](#s3-characteristics)
  - [S3 security](#s3-security)
  - [Host a static website on S3](#host-a-static-website-on-s3)

# Region, AZ, Edge Locations
* multiple availability Zone
* between AZ at least 100 km
* Edgelocation purpose : endpoint for AWS used for Cache , CDN 

# Key Services for the Exam
* Compute: EC2, Lambda, Elastic Beanstalk
* Storage: S3, EBS, EFS, FSx, Storage Gateway
* Databases: RDS, DynamoDB
* Networkings: VPC, direct connect, Route 5, API Gatewayte , AWS Global Accelerator

# AWS Well Architecture Framework
* To read: https://aws.amazon.com/whitepapers/?nc1=h_ls&whitepapers-main.sort-by=item.additionalFields.sortDate&whitepapers-main.sort-order=desc&awsf.whitepapers-content-type=*all&awsf.whitepapers-global-methodology=methodology%23well-arch-framework&awsf.whitepapers-tech-category=*all&awsf.whitepapers-industries=*all&awsf.whitepapers-business-category=*all&whitepapers-main.q=AWS%2Bwell-architected%2Bframework&whitepapers-main.q_operator=AND&awsm.page-whitepapers-main=2


# IAM
* Allow to manage users and teir level of access to the AWS ressources
* IMA isn't related to a region or AZ
* New users: No permiissions when first created
## Root account:
* email adddress to wignup to AWS 
* it has full control of all ressources to AWS
### Secure AWS Root Account
* Enable Multi facture auth
* Create Admin group for administrators, assign appropriate permessions
* Create user accounts for administrators
* Add users to admin group
### Policy
* policy document JSON
* can be assigned To groups & roles (to groups is the more appropriate) 

## Perm IAM credentials
* Users: physical person
* Groups: functions 
* Roles: Internal usage to enable interracting between ressources 

# S3
* Simple Storage Service
  * Scalable 
  * Secure
  * Simple
## S3 Basics
* Upload any type of files
* Cannot used to OS or databases
* Unlimited Storage
* Up to 5 To for each objects
* Universal Namespace : name cannot be already used globaly 
* Key-Value Store
  * Key: name of the object
  * Value: data itself
  * Version ID
  * Metadata: content type, modification date, ...
* High available & High Durable
* URL: 
  * https://bucketname.s3.region.amaso...com/Key-name
  * Successful CLI or API uploads will generate an HTTP 200 status code.

## S3 Standard
1. HA & HD : Replicated on 3 or more AZ
2. Designed for frequent access to data
3. Suitable for most Workloads

## S3 characteristics
* Multiple Storage class for different use cases
* Lifecycle Management
* Versioning : go back and forth between version of S3 object even if it's deleted

## S3 security
* Server side encryption
* Access Control Lists (ACLs) for groups / accoutns
* Bucket policies
* ACLs VS Policies
  * ACLs work on an **individual object** level
  * Bucket policies work on an **entire bucket** level
> **Enable public access to an object**
> 1. Create a bucket
> 2. Upload a file into the bucket (S3 Object)
> 3. Enable Public access (Bucket name ==> Permission ==> Block Public Access)
> 4. Enable ACL on objects (Bucket name ==> Permission ==> Object Ownership)

**Exam Tips**
>* Buckets / Objects are private by default
>* Object ACLs : handle individual object
>* Bucket ACLs : handle entire bucket
>* HTTP Status Code when upload an object is **HTTP 200**

## Host a static website on S3
* Only static web pages not any dynamic websites
* S3 scale automatically 
> How to:
> 1. Create a bucket 
> 2. Upload your static website (at least index.html & error.html)
> 3. Enable Public access (Bucket name ==> Permission ==> Block Public Access)
> 4. Update bucket policy (public access) 
> ```xml
> {
>	"Version": "2012-10-17",
>	"Statement": [
>		{
>			"Sid": "PublicReadGetObject",
>			"Effect": "Allow",
>			"Principal": "*",
>			"Action": [
>				"s3:GetObject"
>			],
>			"Resource": [
>				"arn:aws:s3:::BUCKET_NAME/*"
>			]
>		}
>	]
> }
> ```
> 5. Enable Hosting website on bucket Properties
> 6. Visite your web site (URL: http://BUCKET_NAME.s3-website-REGION.amazonaws.com )

**Exam Tips**
>* Bucket Policies: enable public acces using policies
>* Static content only
>* Automatic Scaling