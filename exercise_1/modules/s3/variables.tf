variable "region" {}
  type        = string
  description = "AWS Region"

variable "capacity" {
  default = "4"
  }

# Variable type 'list'

variable "users" {
    type    = "list"
    default = ["root", "user1", "user2"]
    }

# Variable type 'MAP'

# variable "templates" {
#    type = "map"
#    default = {
#        "template1" = "01000000"
#        "template2" = "02000000"
#        "template3" = "03000000"
#    }
# }


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
