set -x
source openrc.sh
MASTER_IP=`nova show openshift-master | grep avimgmt | awk '{print $5;}'`
NODE1_IP=`nova show openshift-node1 | grep avimgmt | awk '{print $5;}'`
NODE2_IP=`nova show openshift-node2 | grep avimgmt | awk '{print $5;}'`

cp templates/ansible-hosts.template ./hosts
sed -i -e "s/OSMASTER/$MASTER_IP/g" ./hosts
sed -i -e "s/OSNODE1/$NODE1_IP/g" ./hosts
sed -i -e "s/OSNODE2/$NODE2_IP/g" ./hosts

# set allowed address pair
port_id=`neutron port-list | grep "$MASTER_IP" | awk '{print $2;}'`
neutron port-update $port_id  --allowed-address-pairs type=dict list=true ip_address=10.10.32.0/20

# initialize all nodes
for NODEIP in $MASTER_IP $NODE1_IP $NODE2_IP
do
    ./scripts/scp-files.sh $NODEIP
    ssh -t centos@$NODEIP sudo scripts/init-common.sh
done

# add stuff on master
ssh -t centos@$MASTER_IP sudo scripts/init-master.sh

# copy hosts to master
scp ./hosts centos@$MASTER_IP:
ssh -t centos@$MASTER_IP scripts/setup-os.sh
