# Installing Kubernetes

From <https://www.youtube.com/watch?v=UWg3ORRRF60>

## Install

```bash

# Run on both master and worker

ubuntu_adj=bionic # Adjective part of ubuntu release
k_hostname=kmaster # or knode1, etc
k_master_ip=
k_node_ip=

# Prep

doprep() {
    swapoff -a # Prevent using swap because ....?
    sed -r 's/^(.+swap)/#\1/' -i /etc/fstab

    echo "$k_hostname" >/etc/hostname

    # Set static IP
    #netplan ... # Using $k_*_ip

    cat <<EOF >>/etc/hosts
(ip) kmaster
EOF

    paf -i -u openssh-server docker.io -y
}

#doprep

steps_both() {
	# Kubernetes
	
	paf -i -u -y apt-transport-https curl
	echo y|curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
	echo "deb http://apt.kubernetes.io/ kubernetes-$ubuntu_adj main" >/etc/ap/sources.list.d/kubernetes.list
	
	paf -i -u -y kubelet kubeadm kubectl
	
	# Note - does this have to be in-order after last Environment line?
	echo 'Environment="cgroup-driver=systemd/cgroup-driver=cgroupfs"' >> /etc/systemcd/system/kubelet.service.d/10-kubeadm.conf
	
	echo "$k_master_ip kmaster" >> /etc/hosts
	echo "$k_node_ip knode" >> /etc/hosts
}

steps_master() {
	runcmd=(
	kubeadm init # We are setting up the COntainer Network Interface with []
	--pod-network-cidr=192.168.0.0/16 # Range in which to create new containers
	--apiserver-advertise-address=192.168.56.101 # Address reserved for the API server
	)
	"${runcmd[@]}"
	# this will generate a "join" command - copy this (refernced as join_command below)

	# INCOMPLETE ++++++++++++++++++
	# See video at 20:45
	
	# As regular user:
}

steps_both
#steps_master
#steps_node

```


* Cluster has 1 master, N workers
