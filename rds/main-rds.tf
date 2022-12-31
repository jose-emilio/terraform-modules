resource "aws_db_instance" "database" {
   identifier_prefix = var.nombre
   replicate_source_db = var.replica
   engine = var.replica == null ? var.motor : null
   db_name = var.replica == null ? var.basedatos : null
   username = var.replica == null ? var.usuario : null
   password = var.replica == null ? var.password : null
   allocated_storage = var.gb-volumen
   storage_type = "gp3"
   instance_class = var.tipo-instancia
   db_subnet_group_name = aws_db_subnet_group.grupo-subredes.name
   vpc_security_group_ids = [aws_security_group.rds-sg.id]
   multi_az = var.multi-az
   publicly_accessible = false
   backup_retention_period = 1
   skip_final_snapshot = true
}

resource "aws_db_subnet_group" "grupo-subredes" {
   name_prefix = var.nombre
   subnet_ids = var.lista-subredes
}
