terraform {
  backend "s3" {
    bucket = "shitana-tfstate"
    key    = "cloudwatch1/terraform.tfstate"
    region = "eu-west-3"
  }
}
