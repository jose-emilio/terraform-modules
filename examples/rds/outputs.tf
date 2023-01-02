output "rds-endpoint" {
    value = module.database.rds-endpoint 
    description = "Punto de enlace de la BD"
}

output "rds-port" {
   value = module.database.rds-port
   description = "Puerto"
}

output "rds-replica-endpoint" {
    value = module.database-replica.rds-endpoint 
    description = "Punto de enlace de la BD"
}

output "rds-replica-port" {
   value = module.database-replica.rds-port
   description = "Puerto"
}
