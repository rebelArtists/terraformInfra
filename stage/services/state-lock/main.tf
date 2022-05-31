provider "aws" {
  region = "us-east-1"
}

module "state-lock-services-stage" {
  source = "github.com/rebelArtists/terraformModules//global/state-lock?ref=v0.0.1"

  dynamo_table_name = "webserver_state_lock_stage"
  state_bucket_name = "terraform-webservers-stage"
  state_file_key = "terraform.tfstate"
}
