terraform {
   backend "s3" {
      bucket = "tetuan-backend-terraform-state"
      key = "stage/kms/terraform.tfstate"
      region = "us-east-1"

      dynamodb_table = "tetuan-backend-terraform-locks"
      encrypt = true
   }
}
