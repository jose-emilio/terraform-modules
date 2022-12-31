output "alb" {
   value = "http://${aws_lb.mi-alb.dns_name}"
   description = "DNS del ALB"
}

output "ec2-sg" {
   value = aws_security_group.ec2-sg.id
   description = "Grupo de seguridad de las instancias EC2"
}
