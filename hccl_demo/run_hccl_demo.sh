#!/bin/bash
MY_SCRIPT_DIR="$( cd "$(dirname "$0")" && pwd )"

set -x

cross_node=${CROSS_NODE:-0}
node_id=${NODE_ID:-0}

CLEAN="-clean"

# tests
#TEST_CASE=broadcast
#TEST_CASE=all_reduce
#TEST_CASE=reduce_scatter
#TEST_CASE=all_gather
#TEST_CASE=send_recv
#TEST_CASE=reduce
#TEST_CASE=all2all
TEST_CASE=$1

all_gpu=${GPU_TOTAL:-8}
#all_gpu=16 #$2
per_gpu=${GPU_PER_RANK:-8} #$3
ip=${MASTER_IP_PORT:-"127.0.0.1:5555"}

echo $ip

if [ $cross_node -ge 1 ];
then
        echo "Inter-node test..."
        export LIBFABRIC_ROOT=/opt/libfabric
        export LD_LIBRARY_PATH=/opt/libfabric/lib:$LD_LIBRARY_PATH
        export HCCL_OVER_OFI=1
        export HCCL_GAUDI_DIRECT=1
        export HCCL_COMM_ID=$ip
else
        echo "Intra-node test..."
        unset LIBFABRIC_ROOT
        unset LD_LIBRARY_PATH
        unset HCCL_OVER_OFI
        unset HCCL_GAUDI_DIRECT
        export HCCL_OVER_OFI=0
        export HCCL_COMM_ID=$ip
        node_id=0
fi

echo $TEST_CASE
echo $all_gpu
echo $per_gpu

python3 run_hccl_demo.py --test ${TEST_CASE} --nranks ${all_gpu} --loop 1000 --node_id $node_id --size 32m --ranks_per_node ${per_gpu} --size_range 32k 1g --size_range_inc 1

