variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
  type        = string
  default     = "terraform-data-stores-prod"
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in S3"
  type        = string
  default     = "terraform.tfstate"
}

variable "aws_region" {
  description = "aws region to use"
  default = "us-east-1"
}

variable "cluster_name" {
  description = "The name of the environment we're deploying to"
  type        = string
  default     = "webserver-cluster-prod"
}
