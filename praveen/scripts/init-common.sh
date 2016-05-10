set -x
yum install -y wget git net-tools bind-utils iptables-services bridge-utils bash-completion
yum update -y

yum install -y NetworkManager
service NetworkManager start

iptables -F

yum install -y docker
sed -i -e "s/\-\-selinux\-enabled/\-\-selinux\-enabled \-\-insecure\-registry 172.30.0.0\/16/" /etc/sysconfig/docker

systemctl enable docker
systemctl start docker
