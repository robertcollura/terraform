provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

terraform {
  backend "s3" {
  bucket = "rc-tf-remote-state-bucket"
  key = "terraform.tfstate"
  region = "us-east-1"
  }
}

resource "aws_ecs_cluster" "ecs-cluster-1" {
    name = "${var.ecs-cluster-1}"

}

  resource "aws_autoscaling_group" "ecs-autoscaling-group-1" {
    name                        = "ecs-asg-${var.ecs-cluster-1}"
    max_size                    = "4"
    min_size                    = "1"
    desired_capacity            = "${var.capacity}"
    vpc_zone_identifier         = ["subnet-0bacaae249a2fd391","subnet-0bacaae249a2fd391"]
    launch_configuration        = "${aws_launch_configuration.ecs-launch-configuration-1.name}"
    health_check_type           = "ELB"
  }
  resource "aws_launch_configuration" "ecs-launch-configuration-1" {
    name                        = "ecs-lb-${var.ecs-cluster-1}"
    # if the AMI below isn't available, search at AWS AMI's page using this filter 
    # source=amazon/amzn2-ami-ecs-hvm-2.0.20220630-x86_64-ebs
    image_id                    = "ami-09ce6553a7f2ae75d"
    instance_type               = "t2.medium"
    iam_instance_profile        = "ecsInstanceRole"
    root_block_device {
      volume_type = "standard"
      volume_size = 20
      delete_on_termination = true
    }
    lifecycle {
      create_before_destroy = true
    }
    security_groups             = ["sg-37f61246"]
    associate_public_ip_address = "true"
    key_name                    = "harness-delegate"
    user_data                   = <<EOF
                                  #!/bin/bash
                                  echo ECS_CLUSTER=${var.ecs-cluster-1} >> /etc/ecs/ecs.config
                                  EOF
}
