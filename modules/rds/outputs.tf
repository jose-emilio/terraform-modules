output "rds-arn" {
    value = aws_db_instance.database.arn
    description = "ARN de la instancia RDS"
}

output "rds-endpoint" {
    value = aws_db_instance.database.address 
    description = "Punto de enlace de la BD"
}

output "rds-port" {
   value = aws_db_instance.database.port
   description = "Puerto"
}
