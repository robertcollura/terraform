provider "aws" {
  region = "${var.region}"
}

terraform {
   backend "s3" {
   bucket = "rc-tf-remote-state-bucket"
   key = "terraform.tfstate"
   region = "us-east-1"
  }
}

resource "aws_s3_bucket" "tf-child-module-bucket" {
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

###############################################################
### Calling a local module in the same repo (relative path) ###
###############################################################

module "s3_module_local_repo" {
  source = "./modules/s3"
}
  
#####################################################
### Calling a remote module in a private Git repo ###
#####################################################

### NOTE: A ssh key for the private Git repo is required on the Harness delegate for Terraform to download the module
### NOTE: https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account

#module "s3_module_private_repo" {
#  source = "git@github.com:rc-harness/private.git"
#}

####################################################
### Calling a remote module in a public Git repo ###
####################################################
  
### NOTE: No Git credentials/keys required on the Harness delegate for Terraform to download the module
  
#module "s3_module_public_repo" {
#  source = "github.com/rc-harness/public.git"
#}
