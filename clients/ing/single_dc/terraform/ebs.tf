##
# EBS volume for zookeeper
#
resource "aws_ebs_volume" "ebs_zk" {
  availability_zone = "${var.aws_region}a"
  # the same number of ebs volumes as the bookie instance count
  count             = lookup(var.instance_count, var.zk_srv_type, 0)
  type              = lookup(var.ebs_volume_type, var.zk_srv_type, "")
  size              = lookup(var.ebs_volume_size, var.zk_srv_type, 0)

  tags = {
    Name            = format("%s-ebs-zk-%s", var.tag_identifier, count.index)
  }
}
resource "aws_volume_attachment" "zk_ebs_att" {
  device_name       = lookup(var.ebs_device_name, var.zk_srv_type, "")
  count             = lookup(var.instance_count, var.zk_srv_type, 0)
  volume_id         = element(aws_ebs_volume.ebs_zk.*.id, count.index)
  instance_id       = aws_instance.pulsar_srv_zk[count.index].id
}

# EBS volume for bookie journal
resource "aws_ebs_volume" "ebs_bookie_journal" {
  availability_zone = "${var.aws_region}a"
  # the same number of ebs volumes as the bookie instance count
  count             = lookup(var.instance_count, var.bookie_srv_type, 0)
  type              = lookup(var.ebs_volume_type, format("%s-j", var.bookie_srv_type), "")
  size              = lookup(var.ebs_volume_size, format("%s-j", var.bookie_srv_type), 0)

  tags = {
    Name            = format("%s-ebs-bookie-journal-%s", var.tag_identifier, count.index)
  }
}
resource "aws_volume_attachment" "ebs_bookie_journal_att" {
  device_name       = lookup(var.ebs_device_name, format("%s-j", var.bookie_srv_type), "")
  count             = lookup(var.instance_count, var.bookie_srv_type, 0)
  volume_id         = element(aws_ebs_volume.ebs_bookie_journal.*.id, count.index)
  instance_id       = aws_instance.pulsar_srv_bookie[count.index].id
}

# EBS volume for bookie ledger
resource "aws_ebs_volume" "ebs_bookie_ledger" {
  availability_zone = "${var.aws_region}a"
  # the same number of ebs volumes as the bookie instance count
  count             = lookup(var.instance_count, var.bookie_srv_type, 0)
  type              = lookup(var.ebs_volume_type, format("%s-l", var.bookie_srv_type), "")
  size              = lookup(var.ebs_volume_size, format("%s-l", var.bookie_srv_type), 0)

  tags = {
    Name            = format("%s-ebs-bookie-ledger-%s", var.tag_identifier, count.index)
  }
}
resource "aws_volume_attachment" "ebs_bookie_ledger_att" {
  device_name       = lookup(var.ebs_device_name, format("%s-l", var.bookie_srv_type), "")
  count             = lookup(var.instance_count, var.bookie_srv_type, 0)
  volume_id         = element(aws_ebs_volume.ebs_bookie_ledger.*.id, count.index)
  instance_id       = aws_instance.pulsar_srv_bookie[count.index].id
}