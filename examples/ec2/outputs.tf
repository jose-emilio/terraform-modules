output "dns-alb" {
   value = module.mi-ec2.alb
   description = "DNS del ALB"
}

output "ec2-sg" {
   value = module.mi-ec2.ec2-sg
   description = "ID del grupo de seguridad de las instancias EC2"
}
