#
# Pulsar bookie servers for Cluster A and B
#
resource "aws_instance" "pulsar_srv_bookie_A" {
    ami             = var.ami_id
    instance_type   = lookup(var.instance_type, var.bookie_srv_type, "")
    count           = lookup(var.instance_count, var.bookie_srv_type, 0)
    key_name        = format("%s-%s", var.tag_identifier_key, var.aws_keypair_name)
    subnet_id       = aws_subnet.sn_clusterA.id

    root_block_device {
        volume_size     = 10
    }

    vpc_security_group_ids = [ aws_security_group.sg_pub_ssh.id,
                               aws_security_group.sg_trusted_hosts.id,
                               aws_security_group.sg_internal_only.id,
                               aws_security_group.sg_all_outbound.id
                             ]
    
    tags = {
        Name         = format("%s-ClusterA-%s-%s", var.tag_identifier, var.bookie_srv_type, count.index)
    }

    user_data = data.template_file.user_data.rendered
}
resource "aws_instance" "pulsar_srv_bookie_B" {
    ami             = var.ami_id
    instance_type   = lookup(var.instance_type, var.bookie_srv_type, "")
    count           = lookup(var.instance_count, var.bookie_srv_type, 0)
    key_name        = format("%s-%s", var.tag_identifier_key, var.aws_keypair_name)
    subnet_id       = aws_subnet.sn_clusterB.id

    root_block_device {
        volume_size     = 10
    }

    vpc_security_group_ids = [ aws_security_group.sg_pub_ssh.id,
                               aws_security_group.sg_trusted_hosts.id,
                               aws_security_group.sg_internal_only.id,
                               aws_security_group.sg_all_outbound.id
                             ]
    
    tags = {
        Name         = format("%s-ClusterB-%s-%s", var.tag_identifier, var.bookie_srv_type, count.index)
    }

    user_data = data.template_file.user_data.rendered
}

#
# Pulsar broker servers for Cluster A and B
#
resource "aws_instance" "pulsar_srv_broker_A" {
    ami             = var.ami_id
    instance_type   = lookup(var.instance_type, var.broker_srv_type, "")
    count           = lookup(var.instance_count, var.broker_srv_type, 0)
    key_name        = format("%s-%s", var.tag_identifier_key, var.aws_keypair_name)
    subnet_id       = aws_subnet.sn_clusterA.id

    vpc_security_group_ids = [ aws_security_group.sg_pub_ssh.id,
                               aws_security_group.sg_trusted_hosts.id,
                               aws_security_group.sg_internal_only.id,
                               aws_security_group.sg_all_outbound.id
                             ]
    
    tags = {
        Name         = format("%s-ClusterA-%s-%s", var.tag_identifier, var.broker_srv_type, count.index)
    }

    user_data = data.template_file.user_data.rendered
}
resource "aws_instance" "pulsar_srv_broker_B" {
    ami             = var.ami_id
    instance_type   = lookup(var.instance_type, var.broker_srv_type, "")
    count           = lookup(var.instance_count, var.broker_srv_type, 0)
    key_name        = format("%s-%s", var.tag_identifier_key, var.aws_keypair_name)
    subnet_id       = aws_subnet.sn_clusterB.id

    vpc_security_group_ids = [ aws_security_group.sg_pub_ssh.id,
                               aws_security_group.sg_trusted_hosts.id,
                               aws_security_group.sg_internal_only.id,
                               aws_security_group.sg_all_outbound.id
                             ]
    
    tags = {
        Name         = format("%s-ClusterB-%s-%s", var.tag_identifier, var.broker_srv_type, count.index)
    }

    user_data = data.template_file.user_data.rendered
}

#
# EC2 instances for Pulsar zookeeper servers for Cluster A and B
#
resource "aws_instance" "pulsar_srv_zk_A" {
    ami             = var.ami_id
    instance_type   = lookup(var.instance_type, var.zk_srv_type, "")
    count           = lookup(var.instance_count, var.zk_srv_type, 0)
    key_name        = format("%s-%s", var.tag_identifier_key, var.aws_keypair_name)
    subnet_id       = aws_subnet.sn_clusterA.id

    vpc_security_group_ids = [ aws_security_group.sg_pub_ssh.id,
                               aws_security_group.sg_trusted_hosts.id,
                               aws_security_group.sg_internal_only.id,
                               aws_security_group.sg_all_outbound.id
                             ]
    
    tags = {
        Name         = format("%s-ClusterA-%s-%s", var.tag_identifier, var.zk_srv_type, count.index)
    }

    user_data = data.template_file.user_data.rendered
}
resource "aws_instance" "pulsar_srv_zk_B" {
    ami             = var.ami_id
    instance_type   = lookup(var.instance_type, var.zk_srv_type, "")
    count           = lookup(var.instance_count, var.zk_srv_type, 0)
    key_name        = format("%s-%s", var.tag_identifier_key, var.aws_keypair_name)
    subnet_id       = aws_subnet.sn_clusterB.id

    vpc_security_group_ids = [ aws_security_group.sg_pub_ssh.id,
                               aws_security_group.sg_trusted_hosts.id,
                               aws_security_group.sg_internal_only.id,
                               aws_security_group.sg_all_outbound.id
                             ]
    
    tags = {
        Name         = format("%s-ClusterB-%s-%s", var.tag_identifier, var.zk_srv_type, count.index)
    }

    user_data = data.template_file.user_data.rendered
}


#
# EC2 instances for Pulsar client for Cluster A and B
#
resource "aws_instance" "pulsar_clnt_A" {
    ami             = var.ami_id
    instance_type   = lookup(var.instance_type, var.clnt_type, "")
    count           = lookup(var.instance_count, var.clnt_type, 0)
    key_name        = format("%s-%s", var.tag_identifier_key, var.aws_keypair_name)
    subnet_id       = aws_subnet.sn_clusterA.id

    root_block_device {
        volume_size     = 10
    }

    vpc_security_group_ids = [ aws_security_group.sg_pub_ssh.id,
                               aws_security_group.sg_trusted_hosts.id,
                               aws_security_group.sg_internal_only.id,
                               aws_security_group.sg_all_outbound.id
                             ]
    
    tags = {
        Name         = format("%s-ClusterA-%s-%s", var.tag_identifier, var.clnt_type, count.index)
    }

    user_data = data.template_file.user_data.rendered
}
resource "aws_instance" "pulsar_clnt_B" {
    ami             = var.ami_id
    instance_type   = lookup(var.instance_type, var.clnt_type, "")
    count           = lookup(var.instance_count, var.clnt_type, 0)
    key_name        = format("%s-%s", var.tag_identifier_key, var.aws_keypair_name)
    subnet_id       = aws_subnet.sn_clusterB.id

    root_block_device {
        volume_size     = 10
    }

    vpc_security_group_ids = [ aws_security_group.sg_pub_ssh.id,
                               aws_security_group.sg_trusted_hosts.id,
                               aws_security_group.sg_internal_only.id,
                               aws_security_group.sg_all_outbound.id
                             ]
    
    tags = {
        Name         = format("%s-ClusterB-%s-%s", var.tag_identifier, var.clnt_type, count.index)
    }

    user_data = data.template_file.user_data.rendered
}


# GlobalZK
resource "aws_instance" "pulsar_srv_gzk" {
    ami             = var.ami_id
    instance_type   = lookup(var.instance_type, var.gzk_srv_type, "")
    count           = lookup(var.instance_count, var.gzk_srv_type, 0)
    key_name        = format("%s-%s", var.tag_identifier_key, var.aws_keypair_name)
    subnet_id       = aws_subnet.sn_gzk.id

    root_block_device {
        volume_size     = 10
    }

    vpc_security_group_ids = [ aws_security_group.sg_pub_ssh.id,
                               aws_security_group.sg_trusted_hosts.id,
                               aws_security_group.sg_internal_only.id,
                               aws_security_group.sg_all_outbound.id
                             ]
    
    tags = {
        Name         = format("%s-%s-%s", var.tag_identifier, var.gzk_srv_type, count.index)
    }

    user_data = data.template_file.user_data.rendered
}



data "template_file" "user_data" {
   template = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install python-minimal -y
              apt-get install ntp -y
              apt-get install ntpstat -y
              ntpq -pcrv
              EOF
}