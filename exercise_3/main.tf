provider "aws" {
  region = "${var.region}"
}

terraform {
   backend "s3" {
   bucket = "rc-tf-remote-state-bucket"
   region = "us-east-1"
  }
}

resource "aws_s3_bucket" "tf-root-module-bucket" {
  bucket = "${var.s3_bucket_name}"
  acl = "private"
  region = "${var.s3_bucket_region}"
  
  versioning {
    enabled = true
  }
  
  tags = {
    Name        = "${var.s3_bucket_name}"
    Environment = "${var.tag_env}"
  }
}
