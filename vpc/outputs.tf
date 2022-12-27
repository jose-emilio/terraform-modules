output "vpc-id" {
   value = aws_vpc.vpc.id 
   description = "ID de la VPC"
}

output "subredes-publicas" {
   value = aws_subnet.pub-subnets[*].id
   description = "IDs de las subredes públicas"
}

output "subredes-app" {
   value = aws_subnet.app-subnets[*].id 
   description = "IDs de las subredes privadas de la capa APP"
}

output "subredes-db" {
   value = aws_subnet.db-subnets[*].id
   description = "IDs de las subredes privadas de la capa de BBDD"
}
