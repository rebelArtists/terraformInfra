provider "aws" {
  region = "us-east-1"
}

module "state-lock-data-stores-stage" {
  source = "github.com/rebelArtists/terraformModules//global/state-lock?ref=v0.0.1"

  dynamo_table_name = "data_stores_state_lock_stage"
  state_bucket_name = "terraform-data-stores-stage"
  state_file_key = "terraform.tfstate"
}
