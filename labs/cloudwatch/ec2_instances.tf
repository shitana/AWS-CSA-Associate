resource "aws_instance" "web" {
  count         = var.instance_count
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_cloudwatch_profile.name

  # Dynamically assign to the same subnets
  subnet_id = tolist(data.aws_subnet_ids.default.ids)[count.index % length(data.aws_subnet_ids.default.ids)]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  
  user_data = <<-EOF
    #!/bin/bash
    # Install CloudWatch Agent
    dnf install amazon-cloudwatch-agent rsyslog jq tree htop -y
    systemctl start rsyslog
    systemctl enable rsyslog

    # Create CloudWatch Agent configuration file
    cat <<EOT >> /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.d/bootstrap_config.json
    {
      "agent": {
        "metrics_collection_interval": 1,
        "run_as_user": "root",
        "logfile": "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log"
      },
      "logs": {
        "logs_collected": {
          "files": {
            "collect_list": [
              {
                "file_path": "/var/log/messages",
                "log_group_name": "messages",
                "log_stream_name": "{instance_id}",
                "retention_in_days": 1
              },
              {
                "file_path": "/var/log/secure",
                "log_group_name": "secure",
                "log_stream_name": "{instance_id}",
                "retention_in_days": 1
              }
            ]
          }
        }
      },
      "metrics": {
        "aggregation_dimensions": [
          [
            "InstanceId"
          ]
        ],
        "metrics_collected": {
          "cpu": {
            "measurement": [
              "cpu_usage_idle",
              "cpu_usage_iowait",
              "cpu_usage_user",
              "cpu_usage_system"
            ],
            "metrics_collection_interval": 1,
            "resources": [
              "*"
            ],
            "totalcpu": false
          },
          "disk": {
            "resources": [
              "/",
              "/tmp"
            ],
            "measurement": [
              {
                "name": "free",
                "rename": "DISK_FREE",
                "unit": "Gigabytes"
              },
              "total",
              "used"
            ],
            "ignore_file_system_types": [
              "sysfs",
              "devtmpfs"
            ],
            "metrics_collection_interval": 60,
            "append_dimensions": {
              "customized_dimension_key_3": "customized_dimension_value_3",
              "customized_dimension_key_4": "customized_dimension_value_4"
            }
          },
          "diskio": {
            "measurement": [
              "io_time"
            ],
            "metrics_collection_interval": 1,
            "resources": [
              "*"
            ]
          },
          "mem": {
            "measurement": [
              "mem_used_percent"
            ],
            "metrics_collection_interval": 1
          },
          "statsd": {
            "metrics_aggregation_interval": 10,
            "metrics_collection_interval": 10,
            "service_address": ":8125"
          },
          "swap": {
            "measurement": [
              "swap_used_percent"
            ],
            "metrics_collection_interval": 1
          }
        }
      },
      "traces": {
        "buffer_size_mb": 3,
        "concurrency": 8,
        "insecure": false,
        "traces_collected": {
          "xray": {
            "bind_address": "127.0.0.1:2000",
            "tcp_proxy": {
              "bind_address": "127.0.0.1:2000"
            }
          }
        }
      }
    }
    EOT

    # Start the CloudWatch agent
    systemctl enable amazon-cloudwatch-agent
    systemctl start amazon-cloudwatch-agent
  EOF

  tags = {
    Name = "cloudwatch-${count.index}"
  }
}
