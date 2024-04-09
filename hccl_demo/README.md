# hccl demo guide

## get hccl_demo 

- get hccl_demo code from https://github.com/HabanaAI/hccl_demo
    
    ```bash
    git clone -b main --depth=1 https://github.com/HabanaAI/hccl_demo
    cd hccl_demo
    make
    ```
## Use run_hccl_demo.sh on top of hccl_demo

### 4x1 broadcast test

```bash
GPU_TOTAL=4 GPU_PER_RANK=4 bash ./run_hccl_demo.sh broadcast
```
### 8x1 all_gather test

```bash
GPU_TOTAL=8 bash ./run_hccl_demo.sh all_gather
```
### 4x2 all_reduce test, master node (has to) being node 0 with out-of-band ip 198.10.1.20

```bash
GPU_TOTAL=8 MASTER_IP_PORT=198.10.1.20:8989 CROSS_NODE=1 NODE_ID=0 GPU_PER_RANK=4 bash ./run_hccl_demo.sh all_reduce
GPU_TOTAL=8 MASTER_IP_PORT=198.10.1.20:8989 CROSS_NODE=1 NODE_ID=1 GPU_PER_RANK=4 bash ./run_hccl_demo.sh all_reduce
```
### 8x2 broadcast test, master node (has to) being node 0 with out-of-band ip 198.10.1.20

```bash
GPU_TOTAL=16 MASTER_IP_PORT=198.10.1.20:8989 CROSS_NODE=1 NODE_ID=0 bash ./run_hccl_demo.sh broadcast  
GPU_TOTAL=16 MASTER_IP_PORT=198.10.1.20:8989 CROSS_NODE=1 NODE_ID=1 bash ./run_hccl_demo.sh broadcast
```
