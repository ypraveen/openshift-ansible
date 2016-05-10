set -x
sudo mv ./hosts /etc/ansible/hosts
ansible-playbook ./openshift-ansible/playbooks/byo/config.yml

# add password
sudo htpasswd -b /etc/origin/htpasswd demo avi123

cd /etc/origin/master/
oadm registry --config=admin.kubeconfig --credentials=openshift-registry.kubeconfig
cd -

# allow demo user to access/modify images
oadm policy add-role-to-user system:registry demo
oadm policy add-role-to-user admin demo -n openshift
oadm policy add-role-to-user system:image-builder demo
