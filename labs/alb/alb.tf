resource "aws_lb" "web_alb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  # Convert the set of subnet IDs to a list and then slice it
  subnets            = slice(tolist(data.aws_subnet_ids.default.ids), 0, 2)

  security_groups    = [aws_security_group.web_alb_sg.id]

  enable_deletion_protection = false

  tags = {
    Name = "web-alb"
  }
}

resource "aws_lb_target_group" "web_tg" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id  # Replace with your VPC ID

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
  }

  tags = {
    Name = "web-target-group"
  }
}

resource "aws_lb_target_group_attachment" "web_tg_attachment" {
  count            = length(aws_instance.web.*.id)
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

# Make sure to define aws_vpc, aws_subnet, and other dependencies if they're not already in your configuration.
