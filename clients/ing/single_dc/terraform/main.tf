provider "aws" {
    region = var.aws_region
}

# 
# SSH key for public access
#
resource "aws_key_pair" "ppfb_ssh_pubacc" {
    key_name = format("%s-%s", var.tag_identifier_key, var.aws_keypair_name)
    public_key = file(format("%s/%s.pub", var.ssh_key_localpath, var.ssh_key_filename))
}
