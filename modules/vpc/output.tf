output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_cidr" {
  value = aws_vpc.this.cidr_block
}

output "public_subnet_id" {
  value = aws_subnet.this-public-subnet[*].id
}

output "private_subnet_id" {
  value = aws_subnet.this-private-subnet[*].id
}

output "public_subnet_cidr" {
  value = aws_subnet.this-public-subnet[*].cidr_block
}

output "private_subnet_cidr" {
  value = aws_subnet.this-private-subnet[*].cidr_block
}

output "eip_id" {
  value = aws_eip.this-eip[*].id
}

output "gateway_id" {
  value = aws_internet_gateway.this-igw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.this-nat[*].id
}

output "public_rt_id" {
  value = aws_route_table.public-rt.id
}

output "private_rt_id" {
  value = aws_route_table.private-rt.*.id
}

//output "security_group_id" {
  //value = aws_security_group.this-sg.id
//}
