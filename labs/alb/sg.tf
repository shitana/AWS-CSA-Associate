
resource "aws_security_group" "web_alb_sg" {
  name        = "web-alb-sg"
  description = "Security group for ALB"
  vpc_id      = data.aws_vpc.default.id  # Replace with your VPC ID

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Standard egress to allow outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Security group for EC2 instances, allowing access from ALB"
  vpc_id      = data.aws_vpc.default.id  # Ensure this is the correct VPC ID

  # Allow inbound HTTP (port 80) traffic from the ALB
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.web_alb_sg.id]
  }

  # Standard egress to allow outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}

