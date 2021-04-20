#! /bin/bash

terraform plan -out changes.plan 
terraform apply -auto-approve changes.plan 
