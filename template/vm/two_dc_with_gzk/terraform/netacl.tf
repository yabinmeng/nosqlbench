resource "aws_network_acl" "acl_subnet_B" {
    vpc_id        = aws_vpc.vpc_pulsar_2DC.id
    subnet_ids    = var.network_failure == "true" ? [ aws_subnet.sn_clusterB.id ] : []
    #subnet_ids    = [ aws_subnet.sn_clusterB.id ]

    # allow ingress port 22
    ingress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        # cidr_block = var.workstation_pub_ip
        cidr_block = var.allow_all_ip
        from_port  = 22
        to_port    = 22
    }

    # allow ingress port 80 and 443 (for apt-get)
    ingress {
        protocol   = "tcp"
        rule_no    = 120
        action     = "allow"
        cidr_block = var.allow_all_ip
        from_port  = 80
        to_port    = 80
    }
    ingress {
        protocol   = "tcp"
        rule_no    = 140
        action     = "allow"
        cidr_block = var.allow_all_ip
        from_port  = 443
        to_port    = 443
    }
  
    # allow all ingress traffic from subnet B
    ingress {
        protocol   = "all"
        rule_no    = 200
        action     = "allow"
        cidr_block = var.sn_cidr_B 
        from_port  = 0
        to_port    = 0
    }

    # allow all ingress traffic from subnet GZ
    ingress {
        protocol   = "all"
        rule_no    = 300
        action     = "allow"
        cidr_block = var.sn_cidr_GZ
        from_port  = 0
        to_port    = 0
    }

    # allow/deny all ingress traffic from subnet A
    ingress {
        protocol   = "all"
        rule_no    = 400
        action     = var.network_failure == "true" ? "deny" : "allow"
        cidr_block = var.sn_cidr_A 
        from_port  = 0
        to_port    = 0
    }

  
    # allow all egress traffic
    egress {
        protocol   = "all"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }
  
    tags = {
        Name = "${var.tag_identifier}-acl_subnet_B"
    }
}