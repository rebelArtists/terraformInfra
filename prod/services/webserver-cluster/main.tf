provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket  = "terraform-webservers-prod"
    dynamodb_table = "webserver_state_lock_prod"
    region  = "us-east-1"
    key     = "terraform.tfstate"
    encrypt = true
  }
}

module "webserver_cluster_prod" {
  source = "github.com/rebelArtists/terraformModules//services/webserver-cluster?ref=v0.0.4"

  ami = "ami-07ebfd5b3428b6f4d"
  server_text = "prod dogggg"

  cluster_name = "webserver-cluster-prod"
  db_remote_state_bucket = "terraform-data-stores-prod"
  db_remote_state_key = "terraform.tfstate"

  instance_type = "t2.micro"
  min_size = 2
  max_size = 10
  enable_autoscaling = 1
}
