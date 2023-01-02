variable "region" {
   description = "Región donde se crearán los recursos"
   type = string
}

variable "usuario" {
   description = "Nombre de usuario de la BD"
   type = string
}

variable "password" {
   description = "Contraseña de la BD"
   type = string
   sensitive = true
}
