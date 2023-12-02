

# Course details

- [AWS Certified SysOps Admin - Associate (SOA-C02)](https://app.pluralsight.com/library/courses/aws-certified-sysops-admin---associate/exercise-files)
- [Course Resources](https://github.com/ACloudGuru-Resources/course-aws-sysops-administrator-associate/tree/main)


# Section 3 : Deployment, Provisioning, and Automation
## Elastic Block Store (EBS)

* Highly Available / Duplicated within an Availability Zone
* Type :
  * General Pupose SSD GP2 / GP3 up to 16000 IOPS
  * Provisioned IOPS SSD IO1 / IO2 : High perf needs up to 64000 IOPS
  * IO2 Block Express 
  * Optimized HDD ST1 : designed for long term storage
  * Cold HDD SC1 : lowest cost 

[Understanding EBS Volumes, Amazon EBS volume types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html)

### Exam Tips

* EBS SSD 
  * GP2 / GP3 
    * Up to 16000 IOPS
    * Boot disks / general applications
  * IO1 / IO2 
    * Up to 64 000 IOPS
    * Up to 500 IOPS per GiB (50 for io1)
    * OLTP online Transaction processing / Latency sensitive
  * IO2 Block Express (SAN on cloud)
    * Up to 64 TB, 256000 IOPS
    * Large / critical, HP app (SAP HANA, Oracle, DB Server )
* EBS HDD
  * ST1 (not bootable)
    * Throuput optimized for Big Data, Data Warehouse, ...
    * Up to 500 MB /s
  * SC1 (not bootable)
    * Max throuput 250 MB / S
    * Less frequently accessed data