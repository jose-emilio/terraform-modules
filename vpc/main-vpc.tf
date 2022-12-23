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

resource "aws_subnet" "pub-01" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.0.0/24"
   availability_zone = "${var.region}a"
   tags = {
      Name = "${var.nombre}-pub-01"
   }
}

resource "aws_subnet" "app-01" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.1.0/24"
   availability_zone = "${var.region}a"
   tags = {
      Name = "${var.nombre}-app-01"
   }
}

resource "aws_subnet" "db-01" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.2.0/24"
   availability_zone = "${var.region}a"
   tags = {
      Name = "${var.nombre}-db-01"
   }
}

resource "aws_subnet" "pub-02" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.3.0/24"
   availability_zone = "${var.region}b"
   tags = {
      Name = "${var.nombre}-pub-02"
   }
   count = var.zonas >= 2 ? 1 : 0
}

resource "aws_subnet" "app-02" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.4.0/24"
   availability_zone = "${var.region}b"
   tags = {
      Name = "${var.nombre}-app-02"
   }
   count = var.zonas >= 2 ? 1 : 0
}

resource "aws_subnet" "db-02" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.5.0/24"
   availability_zone = "${var.region}b"
   tags = {
      Name = "${var.nombre}-db-02"
   }
   count = var.zonas >= 2 ? 1 : 0
}

resource "aws_subnet" "pub-03" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.6.0/24"
   availability_zone = "${var.region}c"
   tags = {
      Name = "${var.nombre}-pub-03"
   }
   count = var.zonas >= 3 ? 1 : 0
}

resource "aws_subnet" "app-03" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.7.0/24"
   availability_zone = "${var.region}c"
   tags = {
      Name = "${var.nombre}-app-03"
   }
   count = var.zonas >= 3 ? 1 : 0
}

resource "aws_subnet" "db-03" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.8.0/24"
   availability_zone = "${var.region}c"
   tags = {
      Name = "${var.nombre}-db-03"
   }
   count = var.zonas >= 3 ? 1 : 0
}

resource "aws_subnet" "pub-04" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.9.0/24"
   availability_zone = "${var.region}d"
   tags = {
      Name = "${var.nombre}-pub-04"
   }
   count = var.zonas >= 4 ? 1 : 0
}

resource "aws_subnet" "app-04" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.10.0/24"
   availability_zone = "${var.region}d"
   tags = {
      Name = "${var.nombre}-app-04"
   }
   count = var.zonas >= 4 ? 1 : 0
}

resource "aws_subnet" "db-04" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.11.0/24"
   availability_zone = "${var.region}d"
   tags = {
      Name = "${var.nombre}-db-04"
   }
   count = var.zonas >= 4 ? 1 : 0
}

resource "aws_subnet" "pub-05" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.12.0/24"
   availability_zone = "${var.region}e"
   tags = {
      Name = "${var.nombre}-pub-05"
   }
   count = var.zonas >= 5 ? 1 : 0
}

resource "aws_subnet" "app-05" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.13.0/24"
   availability_zone = "${var.region}e"
   tags = {
      Name = "${var.nombre}-app-05"
   }
   count = var.zonas >= 5 ? 1 : 0
}

resource "aws_subnet" "db-05" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.14.0/24"
   availability_zone = "${var.region}e"
   tags = {
      Name = "${var.nombre}-db-05"
   }
   count = var.zonas >= 5 ? 1 : 0
}

resource "aws_subnet" "pub-06" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.15.0/24"
   availability_zone = "${var.region}f"
   tags = {
      Name = "${var.nombre}-pub-06"
   }
   count = var.zonas >= 6 ? 1 : 0
}

resource "aws_subnet" "app-06" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.16.0/24"
   availability_zone = "${var.region}f"
   tags = {
      Name = "${var.nombre}-app-06"
   }
   count = var.zonas >= 6 ? 1 : 0
}

resource "aws_subnet" "db-06" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "172.16.17.0/24"
   availability_zone = "${var.region}f"
   tags = {
      Name = "${var.nombre}-db-06"
   }
   count = var.zonas >= 6 ? 1 : 0
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

resource "aws_route_table_association" "pub1" {
   subnet_id = aws_subnet.pub-01.id
   route_table_id = aws_route_table.ruta-publica.id
}

resource "aws_route_table_association" "pub2" {
   subnet_id = aws_subnet.pub-02[0].id
   route_table_id = aws_route_table.ruta-publica.id
   count = var.zonas >= 2 ? 1 : 0
}

resource "aws_route_table_association" "pub3" {
   subnet_id = aws_subnet.pub-03[0].id
   route_table_id = aws_route_table.ruta-publica.id
   count = var.zonas >= 3 ? 1 : 0
}

resource "aws_route_table_association" "pub4" {
   subnet_id = aws_subnet.pub-04[0].id
   route_table_id = aws_route_table.ruta-publica.id
   count = var.zonas >= 4 ? 1 : 0
}

resource "aws_route_table_association" "pub5" {
   subnet_id = aws_subnet.pub-05[0].id
   route_table_id = aws_route_table.ruta-publica.id
   count = var.zonas >= 5 ? 1 : 0
}

resource "aws_route_table_association" "pub6" {
   subnet_id = aws_subnet.pub-06[0].id
   route_table_id = aws_route_table.ruta-publica.id
   count = var.zonas >= 6 ? 1 : 0
}

resource "aws_eip" "eip-a" {
   count = var.nat == "SI" ? 1 : 0
}

resource "aws_eip" "eip-b" {
   count = var.nat == "SI" && var.zonas >= 2 ? 1 : 0
}

resource "aws_eip" "eip-c" {
   count = var.nat == "SI" && var.zonas >= 3 ? 1 : 0
}

resource "aws_eip" "eip-d" {
   count = var.nat == "SI" && var.zonas >= 4 ? 1 : 0
}

resource "aws_eip" "eip-e" {
   count = var.nat == "SI" && var.zonas >= 5 ? 1 : 0
}

resource "aws_eip" "eip-f" {
   count = var.nat == "SI" && var.zonas >= 6 ? 1 : 0
}

