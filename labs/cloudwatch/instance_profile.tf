resource "aws_iam_instance_profile" "ec2_cloudwatch_profile" {
  name = "EC2CloudWatchProfile"
  role = aws_iam_role.ec2_cloudwatch_role.name
}

