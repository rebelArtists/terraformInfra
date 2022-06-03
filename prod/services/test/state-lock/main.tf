provider "aws" {
  region = "us-east-1"
}

module "state-lock-services-tests" {
  source = "github.com/rebelArtists/terraformModules//global/state-lock?ref=0b73afd"

  dynamo_table_name = "webserver_state_lock_tests"
  state_bucket_name = "terraform-webservers-tests"
  state_file_key = "terraform.tfstate"
  aws_region = "us-east-1"
}
