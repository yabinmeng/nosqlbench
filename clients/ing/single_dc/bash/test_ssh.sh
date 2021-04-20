#!/bin/bash

cat $1 | while read host 
do
    ssh_cmd="ssh -i ~/.ssh/id_rsa_aws_pubacc -oBatchMode=yes -o ConnectTimeout=5 -oStrictHostKeyChecking=accept-new -q ubuntu@$host exit"
    echo $ssh_cmd
    # $ssh_cmd
done