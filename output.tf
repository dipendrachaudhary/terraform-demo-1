//output "vpc_id" {
  //value = module.this_vpc.vpc_id
//}

output "vpc_cidr" {
  value = module.this_vpc.vpc_cidr
}

//output "public_subnet_id" {
  //value = module.this_vpc.public_subnet_id
//}

//output "private_subnet_id" {
  //value = module.this_vpc.private_subnet_id
//}

output "public_subnet_cidr" {
  value = module.this_vpc.public_subnet_cidr
}

output "private_subnet_cidr" {
  value = module.this_vpc.private_subnet_cidr
}

output "pub_instance_pub_ip" {
  value = module.this_ec2.pub_instance_pub_ip
}

output "pub_instance_pri_ip" {
  value = module.this_ec2.pub_instance_pri_ip
}

output "pri_instance_pri_ip" {
  value = module.this_ec2.pri_instance_pri_ip
}
