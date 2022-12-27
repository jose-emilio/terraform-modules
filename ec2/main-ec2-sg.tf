locals {
   http-port = 80
}

resource "aws_security_group_rule" "ingress-rule-alb" {
   type = "ingress"
   from_port = local.http-port 
   to_port = local.http-port 
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
   security_group_id = aws_security_group.alb-sg.id
}

resource "aws_security_group_rule" "ingress-rule-ec2" {
   type = "ingress"
   from_port = local.http-port 
   to_port = local.http-port 
   protocol = "tcp"
   source_security_group_id = aws_security_group.alb-sg.id
   security_group_id = aws_security_group.ec2-sg.id
}

resource "aws_security_group_rule" "egress-rule-alb" {
   type = "egress"
   from_port = local.http-port 
   to_port = local.http-port 
   protocol = "tcp"
   source_security_group_id = aws_security_group.ec2-sg.id
   security_group_id = aws_security_group.alb-sg.id
}

resource "aws_security_group_rule" "egress-rule-ec2" {
   type = "egress"
   from_port = 0 
   to_port = 0
   protocol = -1
   cidr_blocks = ["0.0.0.0/0"]
   security_group_id = aws_security_group.ec2-sg.id
}

resource "aws_security_group" "ec2-sg" {
   name = "${var.nombre}-ec2-sg"
   vpc_id = var.vpc
}

resource "aws_security_group" "alb-sg" {
   name = "${var.nombre}-alb-sg"
   vpc_id = var.vpc
}
