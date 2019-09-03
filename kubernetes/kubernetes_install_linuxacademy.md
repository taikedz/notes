# Install Kubernetes - Linux Academy

From <https://linuxacademy.com/cp/courses/lesson/course/3606/lesson/2/module/267>

Set up 3 servers, 1 master, 2 workers

* 2 CPU
* 4GB

(for local demo in VBox, try 1 CPU, 1GB as a test...)

* On all 3 servers

```bash
sudo -i

# Disable SELinux for purpose of tutorial
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

modprobe br_netfilter
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables

# Turn off swap
# In case of stress, we want correct memory reporting
sed -r 's/^(.*swap)/#\1/' -i /etc/fstab

# Docker
yum install -y yum-utils device-mapper-persistent-data lvm2

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum install docker-ce -y

sed -i -r '/^ExecStart/ s/$/ --exec-opt native.cgroupdriver=systemd/' /usr/lib/systemd/system/docker.service

systemctl daemon-reload

systemctl enable docker --now

# Checks
systemctl status docker
docker info | grep -i cgroup # Check it's systemd

# Add kubernetes repo
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
   https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum -y kubelet kubeadm kubectl

systemctl enable kubelet

# On master, proceed to master
# On nodes, there is a "join" command, copy and go to node setup

```

On master

```bash
kubeadm --init --pod-network-cidr=10.244.0.0/16 # Using flannel

# Retain the token on copied command
# Exit from sudo

mkdir -p ~$HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
# return to sudo

# Check - we are in "NotReady" state
kubectl get nodes

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

sleep 5
# Check - we are in "Ready" state
kubectl get nodes
kubectl get pods --all-namespaces
```

On nodes

```bash
# in sudo

# Run the join command
kubeadm join ...
```

# Networking

`Container Network Interface`

flannel - no network policy, use other provider if needed. But... is this relevant to non-cloud installs...? See github flannel readme

Is a packet forwarder.

Stores state in `etcd`

Check `ip route` on host - default is host's, but kubectl has set up its own routing for local usage and worker access

# Deployment

Deployment defines the update strategy