resource "aws_instance" "web" {
  count         = var.instance_count
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  # Dynamically assign to the same subnets as the ALB
  subnet_id = tolist(data.aws_subnet_ids.default.ids)[count.index % length(data.aws_subnet_ids.default.ids)]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  
  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install httpd -y
                echo "<html><body><h1>Hello from EC2 LAB 1 : ALB. </h1></body></html>" >/var/www/html/index.html
                systemctl start httpd
                systemctl enable httpd
              EOF

  tags = {
    Name = "WebServer-${count.index}"
  }
}
