variable "nombre" {
    description = "Nombre de la infraestructura"
    type = string
}

variable "arquitectura" {
    description = "Tipo de arquitectura. Valores permitidos arm64 / x86_64"
    type = object({
       arch = string
       tipo-instancia = string
    })
    default = {
       arch = "x86_64"
       tipo-instancia = "t3.micro"
    }
}

variable "etiquetas" {
    description = "Etiquetas"
    type = list
}

variable "volumen" {
    description = "Tamaño del volumen EBS de las instancias EC2"
    type = number
    default = 8
    validation {
       condition = var.volumen >= 8
       error_message = "El tamaño del volumen EBS debe ser superior a 8 GB"
    }
}

variable "perfil-instancia" {
    description = "Perfil de la instancia EC2"
    type = string
    default = ""
}

variable "user-data" {
    description = "Ruta al fichero con el script que se ejecutará durante el arranque de las instancias EC2"
    type = string
    default = ""
}

variable "maxsize" {
    description = "Tamaño máximo del grupo de autoescalado"
    type = number
    default = 10
}

variable "minsize" {
    description = "Tamaño mínimo del grupo de autoescalado"
    type = number
    default = 1
}

variable "capacidad-deseada" {
    description = "Tamaño inicial del grupo de autoescalado"
    type = number
    default = 2
}

variable "subredes-ec2" {
    description = "Lista de IDs de subredes donde se desplegarán las instancias EC2"
    type = list(string)
}

variable "subredes-alb" {
    description = "Lista de IDs de subredes donde se desplegará el ALB"
    type = list(string)
}

variable "vpc" {
    description = "ID de la VPC donde se desplegará la infraestructura"
    type = string
}
