provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket  = "terraform-webservers-tests"
    dynamodb_table = "webserver_state_lock_tests"
    region  = "us-east-1"
    key     = "terraform.tfstate"
    encrypt = true
  }
}

module "datastore_cluster_test" {
  source = "github.com/rebelArtists/terraformModules//data-stores/mysql?ref=v0.0.1"

  db_password = "testing123"
  mysql_db_name = "example_db_test"
}
