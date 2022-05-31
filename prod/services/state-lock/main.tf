provider "aws" {
  region = "us-east-1"
}

module "state-lock-services-prod" {
  source = "github.com/rebelArtists/terraformModules//global/state-lock?ref=v0.0.1"

  dynamo_table_name = "webserver_state_lock_prod"
  state_bucket_name = "terraform-webservers-prod"
  state_file_key = "terraform.tfstate"
}
