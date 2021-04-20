#
# Pulsar bookie servers
#
resource "aws_instance" "pulsar_srv_bookie" {
    ami             = var.ami_id
    instance_type   = lookup(var.instance_type, var.bookie_srv_type, "")
    count           = lookup(var.instance_count, var.bookie_srv_type, 0)
    key_name        = format("%s-%s", var.tag_identifier_key, var.aws_keypair_name)
    subnet_id       = aws_subnet.sn_pulsar.id

    vpc_security_group_ids = [ aws_security_group.sg_pub_ssh.id,
                               aws_security_group.sg_trusted_hosts.id,
                               aws_security_group.sg_internal_only.id,
                               aws_security_group.sg_all_outbound.id
                             ]
    
    tags = {
        Name         = format("%s-%s-%s", var.tag_identifier, var.bookie_srv_type, count.index)
    }

    user_data = data.template_file.user_data.rendered
}


#
# Pulsar broker servers
#
resource "aws_instance" "pulsar_srv_broker" {
    ami             = var.ami_id
    instance_type   = lookup(var.instance_type, var.broker_srv_type, "")
    count           = lookup(var.instance_count, var.broker_srv_type, 0)
    key_name        = format("%s-%s", var.tag_identifier_key, var.aws_keypair_name)
    subnet_id       = aws_subnet.sn_pulsar.id

    vpc_security_group_ids = [ aws_security_group.sg_pub_ssh.id,
                               aws_security_group.sg_trusted_hosts.id,
                               aws_security_group.sg_internal_only.id,
                               aws_security_group.sg_all_outbound.id
                             ]
    
    tags = {
        Name         = format("%s-%s-%s", var.tag_identifier, var.broker_srv_type, count.index)
    }

    user_data = data.template_file.user_data.rendered
}


#
# EC2 instances for Pulsar zookeeper servers
#
resource "aws_instance" "pulsar_srv_zk" {
    ami             = var.ami_id
    instance_type   = lookup(var.instance_type, var.zk_srv_type, "")
    count           = lookup(var.instance_count, var.zk_srv_type, 0)
    key_name        = format("%s-%s", var.tag_identifier_key, var.aws_keypair_name)
    subnet_id       = aws_subnet.sn_pulsar.id

    vpc_security_group_ids = [ aws_security_group.sg_pub_ssh.id,
                               aws_security_group.sg_trusted_hosts.id,
                               aws_security_group.sg_internal_only.id,
                               aws_security_group.sg_all_outbound.id
                             ]
    
    tags = {
        Name         = format("%s-%s-%s", var.tag_identifier, var.zk_srv_type, count.index)
    }

    user_data = data.template_file.user_data.rendered
}


#
# EC2 instances for Pulsar client
#
resource "aws_instance" "pulsar_clnt" {
    ami             = var.ami_id
    instance_type   = lookup(var.instance_type, var.clnt_type, "")
    count           = lookup(var.instance_count, var.clnt_type, 0)
    key_name        = format("%s-%s", var.tag_identifier_key, var.aws_keypair_name)
    subnet_id       = aws_subnet.sn_pulsar.id

    root_block_device {
        volume_size     = 10
    }

    vpc_security_group_ids = [ aws_security_group.sg_pub_ssh.id,
                               aws_security_group.sg_trusted_hosts.id,
                               aws_security_group.sg_internal_only.id,
                               aws_security_group.sg_all_outbound.id
                             ]
    
    tags = {
        Name         = format("%s-%s-%s", var.tag_identifier, var.clnt_type, count.index)
    }

    user_data = data.template_file.user_data.rendered
}


#
# EC2 instances for metrics server (Prometheus and Grafana)
#
resource "aws_instance" "metrics_srv" {
    ami             = var.ami_id
    instance_type   = lookup(var.instance_type, var.metrics_srv_type, "")
    count           = lookup(var.instance_count, var.metrics_srv_type, 0)
    key_name        = format("%s-%s", var.tag_identifier_key, var.aws_keypair_name)
    subnet_id       = aws_subnet.sn_pulsar.id

    vpc_security_group_ids = [ aws_security_group.sg_pub_ssh.id,
                               aws_security_group.sg_trusted_hosts.id,
                               aws_security_group.sg_internal_only.id,
                               aws_security_group.sg_webui_pub.id,
                               aws_security_group.sg_all_outbound.id
                             ]
    
    tags = {
        Name         = format("%s-%s-%s", var.tag_identifier, var.metrics_srv_type, count.index)
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