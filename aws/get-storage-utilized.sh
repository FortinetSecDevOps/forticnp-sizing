#!/bin/bash
aws s3api list-buckets --query "Buckets[].Name" | jq '.[]' | sort | xargs -n1 -IBUCKET bash -c "echo BUCKET; aws s3api list-objects --bucket BUCKET --query 'sum(Contents[].Size || [\`0\`])'" | awk 'BEGIN {print "Bucket Name and Size"} {bn=$1; getline ; bs=$1;print bn": "bs ;bt+=bs} END {printf "Total Size: %.6fGB\n", bt/1024/1024/1024}'
