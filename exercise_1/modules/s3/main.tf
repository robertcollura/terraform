resource "aws_s3_bucket" "tf-child-module-bucket" {
  bucket = "${var.bucket_name}"
  acl = "private"
  region = "${var.s3_bucket_region}"
  
  versioning {
    enabled = true
  }
  
  tags = {
    Name        = "${var.tag_name}"
    Environment = "${var.env_name}"
  }
}
