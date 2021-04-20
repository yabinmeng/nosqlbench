#!/bin/bash

cd ../terraform/

TFSTATE_FILE=/tmp/tfshow.txt
terraform show terraform.tfstate > $TFSTATE_FILE

cd ../bash

nodenames=()
private_ips=()
public_ips=()

# print message to a file (appending)
# $1 - message
# $2 - file to append
pmsg() {
   echo "$1" >> $2
}

while IFS= read -r line
do
   if [[ $line == *"aws_instance."* ]]; then
      ## In ${line##*.}"
      ## - "*." matches a string followed by '.'
      ## - "##" drops the longest matching prefix
      ## - "#" drops the shortest matching prefix
      ##-----------------
      ## e.g. "typestr" is like "pulsar_clnt_A[0]:"
      typestr="${line##*.}"
      ## remove trailing ':' character
      typestr=$(echo "$typestr" | sed 's/\://g')
   
      ## replace '[' to '.' and remove ']'
      ##-----------------
      ## e.g. "typestr2" is like "pulsar_srv_A.0"
      typestr2=$(echo "$typestr" | sed 's/\]//' | sed 's/\[/./')

      nodenames+=("$typestr2")
      # nodetypes[${#nodenames[@]}]="$typestr2"
   fi

   if [[ $line == *"private_ip"* ]]; then
      ## exclude "secondary_private_ips"
      if [[ $line != *"ips"* ]]; then
         prv_ip="${line##* = }"
         ## remove all occurence of character '#'
         prv_ip=$(echo $prv_ip | sed 's/\"//g')

         private_ips+=("$prv_ip")
      fi
   fi

   if [[ $line == *"public_ip"* ]]; then
      ## exclude "associate_public_ips_address" and "map_public_ip_on_launch"
      if [[ $line != *"address"* && $line != *"map_public"* ]]; then
         pub_ip="${line##* = }"
         ## remove all occurence of character '#'
         pub_ip=$(echo $pub_ip | sed 's/\"//g')

         public_ips+=("$pub_ip")
      fi
   fi
done < $TFSTATE_FILE

# echo "nodenames: ${nodenames[@]}"
# echo "private_ips: ${private_ips[@]}"
# echo "public_ips: ${public_ips[@]}"

# Generate an IP list file 
IPLIST_FILE="ec2IpList"
PUB_IPLIST_FILE="ec2PubIplist"
publicIpCnt=${#public_ips[*]}

cat /dev/null > $IPLIST_FILE
cat /dev/null > $PUB_IPLIST_FILE
for ((i=0; i<${#nodenames[*]}; i++));
do
   pmsg "${public_ips[i]}" $PUB_IPLIST_FILE

    # in case there is no public IP available,
    #   we use private IP instead
    if [[ $publicIpCnt == 0 ]]; then
       public_ips[i]=${private_ips[i]}
    fi

    pmsg "${nodenames[i]},${public_ips[i]},${private_ips[i]}" $IPLIST_FILE
done

# Generate Ansible inventory files
ANSINV_FILE="ansHosts"
cat /dev/null > $ANSINV_FILE


#################
pmsg "[pulsar:children]" $ANSINV_FILE
pmsg "cluster_srv" $ANSINV_FILE
pmsg "cluster_clnt" $ANSINV_FILE
pmsg "global_zk" $ANSINV_FILE
pmsg "" $ANSINV_FILE

totalHostCnt=${#nodenames[@]}

#################
# Pulsar servers
pmsg "[cluster_srv:children]" $ANSINV_FILE
pmsg "cluster_srv_A" $ANSINV_FILE
pmsg "cluster_srv_B" $ANSINV_FILE
pmsg "" $ANSINV_FILE

pmsg "[cluster_srv_A]" $ANSINV_FILE
for ((i=0; i<$totalHostCnt; i++));
do
   nodeName=${nodenames[i]}
   if [[ "$nodeName" == *"_srv_"* ]]; then
      myarr=(${nodeName//_/ })
      srvType=${myarr[2]}
      cluster=${myarr[3]::1}

      if [[ "$cluster" == "A" ]]; then
         pmsg "${public_ips[i]} private_ip=${private_ips[i]} cluster_name=Cluster$cluster srv_type=$srvType" $ANSINV_FILE
      fi
   fi
done
pmsg "" $ANSINV_FILE

pmsg "[cluster_srv_B]" $ANSINV_FILE
for ((i=0; i<$totalHostCnt; i++));
do
   nodeName=${nodenames[i]}
   if [[ "$nodeName" == *"_srv_"* ]]; then
      myarr=(${nodeName//_/ })
      srvType=${myarr[2]}
      cluster=${myarr[3]::1}

      if [[ "$cluster" == "B" ]]; then
         pmsg "${public_ips[i]} private_ip=${private_ips[i]} cluster_name=Cluster$cluster srv_type=$srvType" $ANSINV_FILE
      fi
   fi
done
pmsg "" $ANSINV_FILE

#################
# Pulsar clients
pmsg "[cluster_clnt]" $ANSINV_FILE
for ((i=0; i<$totalHostCnt; i++));
do
   nodeName=${nodenames[i]}
   if [[ "$nodeName" == *"_clnt_"* ]]; then
      myarr=(${nodeName//_/ })
      cluster=${myarr[2]::1}

      if [[ "$cluster" != "" ]]; then
         pmsg "${public_ips[i]} private_ip=${private_ips[i]} cluster_name=Cluster$cluster" $ANSINV_FILE
      fi
   fi
done
pmsg "" $ANSINV_FILE

#################
# Global Zookeeper server
pmsg "[global_zk]" $ANSINV_FILE
for ((i=0; i<$totalHostCnt; i++));
do
   if [[ ${nodenames[i]} == *"_gzk"* ]]; then
      pmsg "${public_ips[i]} private_ip=${private_ips[i]}" $ANSINV_FILE
   fi
done
pmsg "" $ANSINV_FILE


#################
# Prometheus and Grafana on the metrics server host
pmsg "[metrics]" $ANSINV_FILE
for ((i=0; i<$totalHostCnt; i++));
do
   nodeName=${nodenames[i]}
   if [[ "$nodeName" == *"metrics_srv"* ]]; then
      pmsg "${public_ips[i]} private_ip=${private_ips[i]}" $ANSINV_FILE
   fi
done
pmsg "" $ANSINV_FILE



# Copy the generated ansible inventory file to the proper place
cp $ANSINV_FILE ../ansible/hosts.ini

# Delete intermediate files
rm $ANSINV_FILE
rm $IPLIST_FILE