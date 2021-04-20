# 
# Security group for incoming public SSH access
#
resource "aws_security_group" "sg_pub_ssh" {
    name    = "sg_pub_ssh"
    vpc_id  = aws_vpc.vpc_pulsar.id

    tags = {
        Name         = "${var.tag_identifier}-sg_pub_ssh"
    }

   ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = [var.allow_all_ip]
   }
}

#
# Internal trusted hosts - both Pulsar client and server hosts
# 
resource "aws_security_group" "sg_trusted_hosts" {
    name             = "sg_trusted_hosts"
    vpc_id           = aws_vpc.vpc_pulsar.id

    tags = {
        Name         = "${var.tag_identifier}-sg_trusted_hosts"
    }  
}

#
# Security group for all internal access within the Pulsar instance
#
resource "aws_security_group" "sg_internal_only" {
    name = "sg_internal_only"
    vpc_id  = aws_vpc.vpc_pulsar.id

    tags = {
        Name         = "${var.tag_identifier}-sg_internal_only"
    }

    # Allow all inbound traffic from among internal trusted Pulsar hosts
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        security_groups = [aws_security_group.sg_trusted_hosts.id]
        # cidr_blocks = [var.sn_cidr_A]
    }
}


# 
# Security group to allow all outbound traffic
#
resource "aws_security_group" "sg_all_outbound" {
    name = "sg_all_outbound"
    vpc_id  = aws_vpc.vpc_pulsar.id

    tags = {
        Name         = "${var.tag_identifier}-sg_all_outbound"
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [var.allow_all_ip]
    }
}