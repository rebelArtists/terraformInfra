provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

module "webserver_cluster_prod" {
  source = "github.com/rebelArtists/terraformModules//services/webserver-cluster?ref=79c7b88"

  ami = "${data.aws_ami.ubuntu.id}"
  server_text = "prod dogggg"

  aws_region = "${var.aws_region}"
  cluster_name = "${var.cluster_name}"
  db_remote_state_bucket = "${var.db_remote_state_bucket}"
  db_remote_state_key = "${var.db_remote_state_key}"

  instance_type = "t2.micro"
  min_size = 3
  max_size = 10
  enable_autoscaling = 1
}
