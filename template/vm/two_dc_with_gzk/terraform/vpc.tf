######################################################
# Create a custom VPC. 
#
resource "aws_vpc" "vpc_pulsar_2DC" {
   cidr_block = var.vpc_cidr
   enable_dns_hostnames = true

   tags = {
     Name = "${var.tag_identifier}-vpc_pulsar_2DC"  
   }
}

# subnet for Pulsar ClusterA
resource "aws_subnet" "sn_clusterA" {
    vpc_id      = aws_vpc.vpc_pulsar_2DC.id
    cidr_block  = var.sn_cidr_A
    map_public_ip_on_launch = true
    availability_zone = "${var.aws_region}a"

    tags = {
        Name = "${var.tag_identifier}-sn_clusterA"
    }
}

# subnet for Pulsar ClusterB
resource "aws_subnet" "sn_clusterB" {
    vpc_id      = aws_vpc.vpc_pulsar_2DC.id
    cidr_block  = var.sn_cidr_B
    map_public_ip_on_launch = true
    availability_zone = "${var.aws_region}b"

    tags = {
        Name = "${var.tag_identifier}-sn_clusterB"
    }
}

# subnet for Pulsar Global Zookeeper
resource "aws_subnet" "sn_gzk" {
    vpc_id      = aws_vpc.vpc_pulsar_2DC.id
    cidr_block  = var.sn_cidr_GZ
    map_public_ip_on_launch = true
    availability_zone = "${var.aws_region}c"

    tags = {
        Name = "${var.tag_identifier}-sn_gzk"
    }
}


######################################################
# Create an internet gateway for public/internet access
#
resource "aws_internet_gateway" "ig_pulsar" {
   vpc_id = aws_vpc.vpc_pulsar_2DC.id

   tags = {
     Name = "${var.tag_identifier}-ig_pulsar"  
   }
}

######################################################
# Create a custom route table for public/internet access
#
resource "aws_route_table" "rt_pulsar" {
    vpc_id = aws_vpc.vpc_pulsar_2DC.id

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
resource "aws_route_table_association" "rt_assoc_sn_clusterA" {
    subnet_id = aws_subnet.sn_clusterA.id
    route_table_id = aws_route_table.rt_pulsar.id
}
resource "aws_route_table_association" "rt_assoc_sn_clusterB" {
    subnet_id = aws_subnet.sn_clusterB.id
    route_table_id = aws_route_table.rt_pulsar.id
}
resource "aws_route_table_association" "rt_assoc_sn_gzk" {
    subnet_id = aws_subnet.sn_gzk.id
    route_table_id = aws_route_table.rt_pulsar.id
}