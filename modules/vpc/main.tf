//VPC

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  //enable_classiclink = "false"
  instance_tenancy = "default"
  tags = local.main_tags
}



//Public Subnet

resource "aws_subnet" "this-public-subnet" {
  count = var.count_pub_subnet
  vpc_id = var.vpc_id
  availability_zone = var.availability_zones[count.index]
  cidr_block = var.pub_subnet_cidr_block[count.index]
  map_public_ip_on_launch = "true"
 
  tags = {
    Name = "${var.vpc_name}-pub-subnet-${count.index+1}"
  }
}



//Private  Subnet

resource "aws_subnet" "this-private-subnet" {
  count = var.count_pri_subnet
  vpc_id = var.vpc_id
  availability_zone = var.availability_zones[count.index]
  cidr_block = var.pri_subnet_cidr_block[count.index]
  map_public_ip_on_launch = "false"
  tags = {
    Name = "${var.vpc_name}-pri-subnet-${count.index+1}"
  }
}



//eip

resource "aws_eip" "this-eip" {
  vpc = true
  tags = {
    Name = "${var.vpc_name}-eip"
  }
}



//Internet Gateway

resource "aws_internet_gateway" "this-igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.vpc_name}-ig"
  }
}



//NAT Gateway

resource "aws_nat_gateway" "this-nat" {
  allocation_id = aws_eip.this-eip.id
  subnet_id = aws_subnet.this-public-subnet[0].id
  tags = {
    Name = "${var.vpc_name}-nat"
  }
}



//Public Route Table

resource "aws_route_table" "public-rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }
  route {
    cidr_block = var.vpc_peering_accepter_cidr_block
    vpc_peering_connection_id = var.vpc_peering_connection_id
  }
  tags = local.public_route_tags
}


resource "aws_route_table" "private-rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this-nat.id
  }
  route {
    cidr_block = var.vpc_peering_accepter_cidr_block
    vpc_peering_connection_id = var.vpc_peering_connection_id
  }
  tags = local.private_route_tags
}



//Association Route Table

resource "aws_route_table_association" "this-aso-pub-rt"{
  count = var.count_aso_pub_rt
  subnet_id = aws_subnet.this-public-subnet.*.id[count.index]
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "this-aso-pri-rt"{
  count = var.count_aso_pri_rt
  subnet_id = aws_subnet.this-private-subnet.*.id[count.index]
  route_table_id = aws_route_table.private-rt.id
}
