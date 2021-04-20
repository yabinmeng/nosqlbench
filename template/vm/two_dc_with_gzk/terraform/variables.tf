
# The local directory where the SSH key files are stored
#
variable "ssh_key_localpath" {
   default = "/Users/yabinmeng/.ssh"
}

variable "pubacc_type" {
   default = "pubacc"
}

#
# The local private SSH key file name 
#
variable "ssh_key_filename" {
   default = "id_rsa_aws_pubacc"
}

#
# AWS EC2 key-pair name
#
variable "aws_keypair_name" {
   default   = "ing-sshkey-pubacc"
}
#
# Default AWS region
#
variable "aws_region" {
   default = "us-east-2"
}

#
# Default OS image: Ubuntu
#
variable "ami_id" {
   # Ubuntu Server 16.04 LTS (HVM), SSD Volume Type
   // us-east-1
   #default = "ami-10547475"
   # Ubuntu Server 18.04 LTS (HVM), SSD Volume Type (64-bit x86)
   // us-east-1
   //default = "ami-0bcc094591f354be2"
   // us-east-2
   default = "ami-0e82959d4ed12de3f"
}

#
# AWS resource tag identifier for Pulsar Perf Benchmark (wupoc)
#
variable "tag_identifier_key" {
   default = "ymtest"
} 
variable "tag_identifier" {
   default = "ymtest_pulsar"
} 

#
# Pulsar cluster name
#
variable "bookie_srv_type" {
   default = "bookie"
}
# Broker server type
variable "broker_srv_type" {
   default = "broker"
}
# Zookeeper server type
variable "zk_srv_type" {
   default = "zk"
}
# Pulsar client: where Pulsar clients are running
variable "clnt_type" {
   default = "clnt"
}
# Global zookeeper server type
variable "gzk_srv_type" {
   default = "gzk"
}
# Metrics dashboard server: Prometheus/Grafana and Pulsar Manager
variable "metrics_srv_type" {
   default = "metrics"
}

#
# EBS volume type and device name
# -------------------------------------
# NOTE: currently broker nodes and client nodes
#       don't have extra ebs volume attached
#
variable "ebs_volume_type" {
   type = map
   default = {
      bookie = "gp2"
      zk     = "gp2" 
      gzk    = "gp2"
   }
}
variable "ebs_device_name" {
   type = map
   default = {
      // bookie journal
      bookie-j = "/dev/sdj"
      // bookie ledger
      bookie-l = "/dev/sdl"
      zk       = "/dev/sdh" 
      gzk      = "/dev/sdh"
   }
}


#
# EC2 instance type and count
#
variable "instance_type" {
   type = map
   default = {
      bookie   = "t2.xlarge"
      broker   = "t2.xlarge"
      zk       = "t2.large" 
      clnt     = "t2.xlarge"
      gzk      = "t2.xlarge"
      metrics  = "t2.xlarge"
   }
}
variable "instance_count" {
   type = map
   default = {
      // instance count per Pulsar cluster
      bookie   = 0
      broker   = 0
      zk       = 0
      clnt     = 0

      // instance count (total)
      gzk      = 0
      metrics  = 1
   }
}


## CIDR for VPC and subnets (public and private)
variable "vpc_cidr" {
   default = "172.16.0.0/16"
}
variable "sn_cidr_A" {
   default = "172.16.10.0/24"
}
variable "sn_cidr_B" {
   default = "172.16.20.0/24"
}
variable "sn_cidr_GZ" {
   default = "172.16.30.0/24"
}

variable "allow_all_ip" {
   default = "0.0.0.0/0"
}


## Simulate network failure between subnet A (sn_cidr_A/ClusterA) and subnet B (sn_cidr_B/ClusterB)
variable "network_failure" {
   default = "false"
}


## Public accessible web UI ports
variable "pulsar_manager_webui_port" {
   default = "7750"
}

variable "grafana_webui_port" {
   default = "3000"
}

variable "prometheus_webui_port" {
   default = "9090"
} 