#!/bin/sh

# -e JOBS="job_name@ip:port "
JOBS=`echo $JOBS`
for job in $JOBS; do
  job_name=`echo $job | cut -d"@" -f1`
  uri=`echo $job | cut -d"@" -f2`
cat <<EOF | tee -a prometheus.yml
  - job_name: "$job_name"
    static_configs:
      - targets: ["$uri"]
EOF

done

./prometheus --config.file=prometheus.yml