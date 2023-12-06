provider "aws" {
  region = "us-west-2" # Change this to your AWS region
}

resource "aws_instance" "web" {
  count         = 2 # Creates two instances
  ami           = "ami-0abcdef1234567890" # Replace with the correct AMI ID
  instance_type = "t2.micro"

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install httpd -y
    echo "<html><body><h1>Hello Cloud Gurus - This web page is being served from EC2.</h1></body></html>" >/var/www/html/index.html
    systemctl start httpd
    systemctl enable httpd
  EOF

  tags = {
    Name = "WebServer-${count.index}"
  }
}

resource "aws_elb" "web" {
  name               = "web-elb"
  availability_zones = ["us-west-2a", "us-west-2b"] # Change this to your zones

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = aws_instance.web.*.id
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "web-elb"
  }
}

