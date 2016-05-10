set -x
yum -y install \
    https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-6.noarch.rpm
sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo
yum -y --enablerepo=epel install ansible pyOpenSSL
yum -y install ansible pyOpenSSL

git clone https://github.com/ypraveen/openshift-ansible

