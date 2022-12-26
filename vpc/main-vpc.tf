resource "aws_vpc" "vpc" {
   cidr_block = "172.16.0.0/16"
   tags = {
     Name = var.nombre
   }
}

resource "aws_internet_gateway" "igw" {
   vpc_id = aws_vpc.vpc.id
   tags = {
      Name = "${var.nombre}-igw"
   }
}

resource "aws_subnet" "pub-subnets" {
   vpc_id = aws_vpc.vpc.id
   count = var.zonas
   cidr_block = var.pub-subnets[count.index]
   availability_zone = data.aws_availability_zones.available.names[count.index]
   tags = {
      Name = "${var.nombre}-pub-${count.index}"
   }
}

resource "aws_subnet" "app-subnets" {
   vpc_id = aws_vpc.vpc.id
   count = var.zonas
   cidr_block = var.app-subnets[count.index]
   availability_zone = data.aws_availability_zones.available.names[count.index]
   tags = {
      Name = "${var.nombre}-app-${count.index}"
   }
}

resource "aws_subnet" "db-subnets" {
   vpc_id = aws_vpc.vpc.id
   count = var.zonas
   cidr_block = var.db-subnets[count.index]
   availability_zone = data.aws_availability_zones.available.names[count.index]
   tags = {
      Name = "${var.nombre}-db-${count.index}"
   }
}

resource "aws_route_table" "ruta-publica" {
   vpc_id = aws_vpc.vpc.id
   route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
   }
   tags = {
      Name = "${var.nombre}-ruta-publica"
   }
}

resource "aws_route_table_association" "asociacion-pub" {
   count = var.zonas
   subnet_id = aws_subnet.pub-subnets[count.index].id
   route_table_id = aws_route_table.ruta-publica.id
}

resource "aws_eip" "eip" {
   count = var.nat == "SI" ? var.zonas : 0
}

resource "aws_route_table" "ruta-privada" {
   count = var.zonas 
   vpc_id = aws_vpc.vpc.id
   tags = {
      Name = "${var.nombre}-ruta-privada-${local.zonas[count.index]}"
   }
}

resource "aws_nat_gateway" "natgw" {
   count = var.nat == "SI" ? var.zonas : 0
   allocation_id = aws_eip.eip[count.index].id
   subnet_id = aws_subnet.pub-subnets[count.index].id
   tags = {
      Name = "${var.nombre}-nat-${local.zonas[count.index]}"
   }
   depends_on = [aws_internet_gateway.igw]
}
 
resource "aws_route" "ruta-nat" {
   count = var.nat == "SI" ? var.zonas : 0
   destination_cidr_block = "0.0.0.0/0"
   route_table_id = aws_route_table.ruta-privada[count.index].id
   nat_gateway_id = aws_nat_gateway.natgw[count.index].id
}

resource "aws_route_table_association" "asociacion-app" {
   count = var.zonas
   subnet_id = aws_subnet.app-subnets[count.index].id
   route_table_id = aws_route_table.ruta-privada[count.index].id
}

resource "aws_route_table_association" "asociacion-db" {
   count = var.zonas
   subnet_id = aws_subnet.db-subnets[count.index].id
   route_table_id = aws_route_table.ruta-privada[count.index].id
}

