locals {
   rds-port = var.motor == "mariadb" || var.motor == "mysql" ? 3306 : 5432
}

resource "aws_security_group_rule" "ingress-rule-rds" {
   type = "ingress"
   from_port = local.rds-port 
   to_port = local.rds-port 
   protocol = "tcp"
   source_security_group_id = var.seguridad-ec2
   cidr_blocks = var.seguridad-ec2 == null ? ["0.0.0.0/0"] : null
   security_group_id = aws_security_group.rds-sg.id
}

resource "aws_security_group_rule" "egress-rule-rds" {
   type = "egress"
   from_port = 0 
   to_port = 0
   protocol = -1
   cidr_blocks = ["0.0.0.0/0"]
   security_group_id = aws_security_group.rds-sg.id
}

resource "aws_security_group" "rds-sg" {
   name = "${var.nombre}-rds-sg"
   vpc_id = var.vpc
}
