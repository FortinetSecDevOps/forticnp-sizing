#!/bin/bash
aws ec2 describe-regions --query 'Regions[].RegionName' | jq '.[]' | sort | xargs -n1 -IREGION bash -c "echo -e REGION; aws ec2 describe-instances --region REGION --query 'Reservations[].Instances[].InstanceId | length(@)'" | awk 'BEGIN {print "Region Name and VM Count"} {rn=$1; getline ; vc=$1;print rn": "vc ;vt+=vc} END {print "Total VMs: " vt}'
