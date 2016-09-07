#!/bin/bash

#head node
sudo yum install -y -q nfs-utils 
mkdir /var/nfsshare
chmod -R 777 /var/nfsshare/
systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap
echo "/mnt/nfsshare    10.2.1.*(rw,sync,hard,intr,no_root_squash,no_all_squash)" >> /etc/exports
systemctl restart nfs-server

#compute nodes
sudo yum install -y -q nfs-utils
mkdir -p /mnt/nfsshare
systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap
echo "10.2.1.7:/mnt/nfsshare    /mnt/nfsshare   nfs defaults 0 0" >> /etc/fstab
mount -a
