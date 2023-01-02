terraform {
   backend "s3" {
      bucket = "tetuan-backend-terraform-state"
      key = "stage/rds/terraform.tfstate"
      region = "us-east-1"

      dynamodb_table = "tetuan-backend-terraform-locks"
      encrypt = true
   }
}

data "terraform_remote_state" "vpc" {
   backend = "s3"
   config = {
      bucket = "tetuan-backend-terraform-state"
      key = "stage/vpc/terraform.tfstate"
      region = "us-east-1"
   }
}

data "terraform_remote_state" "ec2" {
   backend = "s3"
   config = {
      bucket = "tetuan-backend-terraform-state"
      key = "stage/ec2/terraform.tfstate"
      region = "us-east-1"
   }
}
