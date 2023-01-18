
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

