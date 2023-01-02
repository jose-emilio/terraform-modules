variable "nombre" {
   description = "Nombre de la instancia RDS"
   type = string
}

variable "vpc" {
   description = "ID de la VPC donde se creará la instancia RDS"
   type = string
}

variable "usuario" {
   description = "Nombre de usuario de la BD"
   type = string
   default = null
}

variable "password" {
   description = "Contraseña de la BD"
   type = string
   default = null
   sensitive = true
}

variable "basedatos" {
   description = "Base de datos inicial"
   type = string
   default = "dbsample"
}

variable "lista-subredes" {
   description = "Lista de subredes donde se desplegará la instancia RDS"
   type = list(string)
}

variable "seguridad-ec2" {
   description = "Grupo de seguridad de la capa de instancias EC2 que accederá a la BD"
   type = string
   default = null
}

variable "tipo-instancia" {
    description = "Tipo de instancia de RDS"
    type = string 
    default = "db.t4g.micro" 
}

variable "gb-volumen" {
    description = "Tamaño del volumen en GB"
    type = number
    validation {
       condition = var.gb-volumen >= 20
       error_message = "El tamaño del volumen EBS debe ser al menos 20 GB"
    }
}

variable "motor" {
    description = "Motor de la BD"
    type = string
    validation {
       condition = var.motor == "mariadb" || var.motor == "mysql" || var.motor == "postgres"
       error_message = "El motor de la BD debe ser mariadb, mysql o postgres" 
    }
    default = "mariadb"
}

variable "replica" {
    description = "ARN de la BD principal de la cual será réplica de lectura"
    type = string
    default = null
}


variable "multi-az" {
    description = "Indica si la instancia RDS se desplegará en Multi-AZ (true) o no (false)"
    type = bool
    default = false
}

variable "etiquetas" {
    description = "Etiquetas"
    type = list
    default = null
}
