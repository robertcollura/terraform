resource "aws_s3_bucket" "tf-child-module-bucket" {
  bucket = "tf-child-module-bucket-rc"
  acl = "private"
  
  versioning {
    enabled = true
  }
  
  tags = {
    Name        = "RC's Bucket"
    Environment = "Training"
  }
}
