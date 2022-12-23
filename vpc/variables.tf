variable "nombre" {
    description = "Nombre de la VPC"
    type = string
}

variable "region" {
    description = "Región donde se desplegará la VPC"
    type = string
}

variable "zonas" {
    description = "Número de zonas de disponibilidad"
    type = number
    validation {
       condition = var.zonas >= 1 && var.zonas <= 6
       error_message = "El número de zonas debe estar entre 1 y 6. Consulte la documentación de AWS para conocer el número de AZs de cada región"
   }
}

variable "nat" {
    description = "Booleano que describe si se crearán o no NAT Gateways (SI / NO)"
    type = string
    validation {
      condition = var.nat=="SI" || var.nat=="NO"
      error_message = "Debes elegir SI o NO"
   }
}
