module "database" {
    #source = "github/joseemilio-vera/terraform-modules//rds
    source = "../../modules/rds"
    nombre = "stage"
    vpc = data.terraform_remote_state.vpc.outputs.vpc-id
    usuario = var.usuario
    password = var.password
    basedatos = "testdb"
    lista-subredes = data.terraform_remote_state.vpc.outputs.subredes-db
    seguridad-ec2 = data.terraform_remote_state.ec2.outputs.ec2-sg 
    tipo-instancia = "db.t4g.small"
    gb-volumen = 30
    motor = "mysql"
}

module "database-replica" {
    #source = "github/joseemilio-vera/terraform-modules//rds
    source = "../../modules/rds"
    nombre = "stage-replica"
    vpc = data.terraform_remote_state.vpc.outputs.vpc-id
    replica = module.database.rds-arn
    lista-subredes = data.terraform_remote_state.vpc.outputs.subredes-db
    seguridad-ec2 = data.terraform_remote_state.ec2.outputs.ec2-sg 
    tipo-instancia = "db.t4g.small"
    gb-volumen = 30
    motor = "mysql"
}
