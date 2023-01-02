output "vpc-id" {
   value = module.mi-vpc.vpc-id
   description = "ID de la VPC"
}

output "subredes-publicas" {
   value = module.mi-vpc.subredes-publicas
   description = "IDs de las subredes públicas"
}

output "subredes-app" {
   value = module.mi-vpc.subredes-app
   description = "IDs de las subredes privadas de la capa APP"
}

output "subredes-db" {
   value = module.mi-vpc.subredes-db
   description = "IDs de las subredes privadas de la capa de BBDD"
}
