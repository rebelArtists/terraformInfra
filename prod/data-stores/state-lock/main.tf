provider "aws" {
  region = "us-east-1"
}

module "state-lock-services-prod" {
  source = "github.com/rebelArtists/terraformModules//global/state-lock?ref=v0.0.1"

  dynamo_table_name = "data_stores_state_lock_prod"
  state_bucket_name = "terraform-data-stores-prod"
  state_file_key = "terraform.tfstate"
}
