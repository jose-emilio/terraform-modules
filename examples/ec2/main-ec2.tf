module "mi-ec2" {
#   source = "github.com/joseemilio-vera/terraform-modules//vpc?ref=v0.1.1"
   source = "../../modules/ec2"
   nombre = "stage"
   arquitectura = {
       arch = "arm64"
       tipo-instancia = "t4g.micro"
   }
   subredes-ec2 = data.terraform_remote_state.vpc.outputs.subredes-app
   subredes-alb = data.terraform_remote_state.vpc.outputs.subredes-publicas
   vpc = data.terraform_remote_state.vpc.outputs.vpc-id
   user-data = "./script.sh"
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
