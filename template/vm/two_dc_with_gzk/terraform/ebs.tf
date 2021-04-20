##
# Global ZK
#
# EBS volume for global zookeeper
resource "aws_ebs_volume" "ebs_gzk" {
  availability_zone = "${var.aws_region}c"
  # the same number of ebs volumes as the bookie instance count
  count             = lookup(var.instance_count, var.gzk_srv_type, 0)
  type              = lookup(var.ebs_volume_type, var.gzk_srv_type, "")
  size              = 1

  tags = {
    Name            = format("%s-GZK-ebs-%s", var.tag_identifier, count.index)
  }
}
resource "aws_volume_attachment" "gzk_ebs_att" {
  device_name       = lookup(var.ebs_device_name, var.gzk_srv_type, "")
  count             = lookup(var.instance_count, var.gzk_srv_type, 0)
  volume_id         = element(aws_ebs_volume.ebs_gzk.*.id, count.index)
  instance_id       = aws_instance.pulsar_srv_gzk[count.index].id
}


##
# ClusterA
#
# EBS volume for zookeeper
resource "aws_ebs_volume" "ebs_zk_A" {
  availability_zone = "${var.aws_region}a"
  # the same number of ebs volumes as the bookie instance count
  count             = lookup(var.instance_count, var.zk_srv_type, 0)
  type              = lookup(var.ebs_volume_type, var.zk_srv_type, "")
  size              = 1

  tags = {
    Name            = format("%s-ClusterA-ebs-zk-%s", var.tag_identifier, count.index)
  }
}
resource "aws_volume_attachment" "zk_ebs_att_A" {
  device_name       = lookup(var.ebs_device_name, var.zk_srv_type, "")
  count             = lookup(var.instance_count, var.zk_srv_type, 0)
  volume_id         = element(aws_ebs_volume.ebs_zk_A.*.id, count.index)
  instance_id       = aws_instance.pulsar_srv_zk_A[count.index].id
}

# EBS volume for bookie journal
resource "aws_ebs_volume" "ebs_bookie_journal_A" {
  availability_zone = "${var.aws_region}a"
  # the same number of ebs volumes as the bookie instance count
  count             = lookup(var.instance_count, var.bookie_srv_type, 0)
  type              = lookup(var.ebs_volume_type, var.bookie_srv_type, "")
  size              = 1

  tags = {
    Name            = format("%s-ClusterA-ebs-bookie-journal-%s", var.tag_identifier, count.index)
  }
}
resource "aws_volume_attachment" "ebs_bookie_journal_att_A" {
  device_name       = lookup(var.ebs_device_name, format("%s-j", var.bookie_srv_type), "")
  count             = lookup(var.instance_count, var.bookie_srv_type, 0)
  volume_id         = element(aws_ebs_volume.ebs_bookie_journal_A.*.id, count.index)
  instance_id       = aws_instance.pulsar_srv_bookie_A[count.index].id
}

# EBS volume for bookie ledger
resource "aws_ebs_volume" "ebs_bookie_ledger_A" {
  availability_zone = "${var.aws_region}a"
  # the same number of ebs volumes as the bookie instance count
  count             = lookup(var.instance_count, var.bookie_srv_type, 0)
  type              = lookup(var.ebs_volume_type, var.bookie_srv_type, "")
  size              = 2

  tags = {
    Name            = format("%s-ClusterA-ebs-bookie-ledger-%s", var.tag_identifier, count.index)
  }
}
resource "aws_volume_attachment" "ebs_bookie_ledger_att_A" {
  device_name       = lookup(var.ebs_device_name, format("%s-l", var.bookie_srv_type), "")
  count             = lookup(var.instance_count, var.bookie_srv_type, 0)
  volume_id         = element(aws_ebs_volume.ebs_bookie_ledger_A.*.id, count.index)
  instance_id       = aws_instance.pulsar_srv_bookie_A[count.index].id
}


##
# ClusterB
#
# EBS volume for zookeeper
resource "aws_ebs_volume" "ebs_zk_B" {
  availability_zone = "${var.aws_region}b"
  # the same number of ebs volumes as the bookie instance count
  count             = lookup(var.instance_count, var.zk_srv_type, 0)
  type              = lookup(var.ebs_volume_type, var.bookie_srv_type, "")
  size              = 1

  tags = {
    Name            = format("%s-ClusterB-ebs-zk-%s", var.tag_identifier, count.index)
  }
}
resource "aws_volume_attachment" "zk_ebs_att_B" {
  device_name       = "/dev/sdh"
  count             = lookup(var.instance_count, var.zk_srv_type, 0)
  volume_id         = element(aws_ebs_volume.ebs_zk_B.*.id, count.index)
  instance_id       = aws_instance.pulsar_srv_zk_B[count.index].id
}

# EBS volume for bookie journal
resource "aws_ebs_volume" "ebs_bookie_journal_B" {
  availability_zone = "${var.aws_region}b"
  # the same number of ebs volumes as the bookie instance count
  count             = lookup(var.instance_count, var.bookie_srv_type, 0)
  type              = lookup(var.ebs_volume_type, var.bookie_srv_type, "")
  size              = 1

  tags = {
    Name            = format("%s-ClusterB-ebs-bookie-journal-%s", var.tag_identifier, count.index)
  }
}
resource "aws_volume_attachment" "ebs_bookie_journal_att_B" {
  device_name       = lookup(var.ebs_device_name, format("%s-j", var.bookie_srv_type), "")
  count             = lookup(var.instance_count, var.bookie_srv_type, 0)
  volume_id         = element(aws_ebs_volume.ebs_bookie_journal_B.*.id, count.index)
  instance_id       = aws_instance.pulsar_srv_bookie_B[count.index].id
}

# EBS volume for bookie ledger
resource "aws_ebs_volume" "ebs_bookie_ledger_B" {
  availability_zone = "${var.aws_region}b"
  # the same number of ebs volumes as the bookie instance count
  count             = lookup(var.instance_count, var.bookie_srv_type, 0)
  type              = lookup(var.ebs_volume_type, var.bookie_srv_type, "")
  size              = 2

  tags = {
    Name            = format("%s-ClusterB-ebs-bookie-ledger-%s", var.tag_identifier, count.index)
  }
}
resource "aws_volume_attachment" "ebs_bookie_ledger_att_B" {
  device_name       = lookup(var.ebs_device_name, format("%s-l", var.bookie_srv_type), "")
  count             = lookup(var.instance_count, var.bookie_srv_type, 0)
  volume_id         = element(aws_ebs_volume.ebs_bookie_ledger_B.*.id, count.index)
  instance_id       = aws_instance.pulsar_srv_bookie_B[count.index].id
}