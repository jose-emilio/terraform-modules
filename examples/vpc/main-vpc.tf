module "mi-vpc" {
#   source = "github.com/joseemilio-vera/terraform-modules//vpc?ref=v0.1.1"
   source = "../../modules/vpc"
   nombre = "stage"
   zonas = 3
   nat = true 
   etiquetas = [
       {
          name = "Environment"
          value = "staging"
       },
       {
          name = "Owner"
          value = "JoseEmilio"
       },
       {
          name = "ManagedBy"
          value = "Terraform"
       }
   ]
}
