######################################################
# Create a custom VPC. 
#
resource "aws_vpc" "vpc_pulsar_1DC" {
   cidr_block = var.vpc_cidr
   enable_dns_hostnames = true

   tags = {
     Name = "${var.tag_identifier}-vpc_pulsar_1DC"  
   }
}

resource "aws_subnet" "sn_pulsar" {
    vpc_id      = aws_vpc.vpc_pulsar_1DC.id
    cidr_block  = var.sn_cidr
    map_public_ip_on_launch = true
    availability_zone = "${var.aws_region}a"

    tags = {
        Name = "${var.tag_identifier}-sn_pulsar"
    }
}


######################################################
# Create an internet gateway for public/internet access
#
resource "aws_internet_gateway" "ig_pulsar" {
   vpc_id = aws_vpc.vpc_pulsar_1DC.id

   tags = {
     Name = "${var.tag_identifier}-ig_pulsar"  
   }
}

######################################################
# Create a custom route table for public/internet access
#
resource "aws_route_table" "rt_pulsar" {
    vpc_id = aws_vpc.vpc_pulsar_1DC.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig_pulsar.id
    }

    tags = {
        Name = "${var.tag_identifier}-rt_pulsar"
    }
}

######################################################
# Associate the route table to the public facing subnet
# 
resource "aws_route_table_association" "rt_assoc_sn_pulsar" {
    subnet_id = aws_subnet.sn_pulsar.id
    route_table_id = aws_route_table.rt_pulsar.id
}