provider "aws" {
  region     = "${var.region}"
}

terraform {
  backend "s3" {
  bucket = "rc-tf-remote-state-bucket"
  key = "terraform.tfstate"
  region = "us-east-1"
  }
}

# References main.tf config in S3 module
module "s3_module_same_repo" {
  source = "./modules/s3"
}
  
# References main.tf config in a remote private git repo
# A git ssh key for the private repo is required on the Harness delegate for Terraform to perform git clone
# https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account

 # module "s3_private_repo" {
 #  source = "git@github.com:rc-harness/private.git"
 # }

# References main.tf config in a pulic git repo
  
 # module "s3_public_repo" {
 #  source = "github.com/rc-harness/public.git"
 # }
