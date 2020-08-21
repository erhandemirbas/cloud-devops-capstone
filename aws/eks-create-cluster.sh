eksctl create cluster \
--name cluster-capstone \
--version 1.14 \
--nodegroup-name workers \
--node-type t2.micro \
--nodes 2 \
--nodes-min 1 \
--nodes-max 3 \
--node-ami auto