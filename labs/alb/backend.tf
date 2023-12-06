terraform {
  backend "s3" {
    bucket = "shitana-tfstate"
    key    = "alblab1/terraform.tfstate"
    region = "eu-west-3"
  }
}
