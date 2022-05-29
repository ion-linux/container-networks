#!/bin/bash
if [$# -ne 1]; then
   echo "Incorrect args. Usage: $0 <interface>"
   exit 1
fi

sudo tshark -i $1 -T fields \
-e ip.src \
-e ip.dst \
-e frame.protocols \
-E header=y

# ./capture.sh ens5
# ./capture.sh tun0
# ./capture.sh br0
