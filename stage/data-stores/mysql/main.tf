provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket  = "terraform-data-stores-stage"
    dynamodb_table = "data_stores_state_lock_stage"
    region  = "us-east-1"
    key     = "terraform.tfstate"
    encrypt = true
  }
}

module "datastore_cluster_stage" {
  source = "github.com/rebelArtists/terraformModules//data-stores/mysql?ref=v0.0.1"

  db_password = "testing123"
  mysql_db_name = "example_db_stage"
}
