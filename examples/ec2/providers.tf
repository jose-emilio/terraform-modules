provider "aws" {
   region = var.region
   default_tags {
      tags = {
         Owner = "JoseEmilio"
         ManagedBy = "Terraform"
      }
   }
}
