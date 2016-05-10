set -x
scp -i ./fedora.pem -r scripts/ centos@$1:

scp -i ./fedora.pem ~/.ssh/id_rsa.pub centos@$1:
scp -i ./fedora.pem ~/.ssh/id_rsa centos@$1:.ssh/
scp -i ./fedora.pem ./config centos@$1:.ssh/

ssh -i ./fedora.pem centos@$1 "cat id_rsa.pub >> .ssh/authorized_keys"
ssh -t -i ./fedora.pem centos@$1 "sudo cp id_rsa.pub /root/.ssh/authorized_keys; sudo chmod 700 /root/.ssh/authorized_keys"
ssh -t -i ./fedora.pem centos@$1 "sudo cp .ssh/id_rsa /root/.ssh/; sudo chmod 700 /root/.ssh/id_rsa"
ssh -i ./fedora.pem centos@$1 "rm -rf id_rsa.pub"

