variable "region" {
   description = "Región donde se creará el backend (S3 y DynamoDB)"
   type = string
}

variable "nombre" {
   description = "Prefijo del bucket de S3 y de la tabla de DynamoDB"
   type = string
}
