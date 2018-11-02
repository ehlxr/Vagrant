#!/bin/bash

set -e

# echo -e "\033[1;33mChange repo to aliyun...\033[0m"
# mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
# wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
# yum clean all
# yum makecache

echo -e "\033[1;33mUpdating...\033[0m"
# resolve issue "https://github.com/jeff1evesque/drupal-demonstration/issues/532"
curl --remote-name --location https://yum.puppetlabs.com/RPM-GPG-KEY-puppet
rpm --import RPM-GPG-KEY-puppet
yum -y update

echo -e "\033[1;33mInstall Packages...\033[0m"
yum install vim net-tools zsh git -y

echo -e "\033[1;33mInstall oh-my-zsh...\033[0m"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo -e "\033[1;33mInstall oh-my-zsh plugins...\033[0m"
git clone https://github.com/zsh-users/zsh-autosuggestions /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search.git /root/.oh-my-zsh/custom/plugins/history-substring-search

echo -e "\033[1;33mConfig oh-my-zsh...\033[0m"
cp -f /vagrant/config/zshrc ~/.zshrc
cp -f /vagrant/config/my.zsh ~/.oh-my-zsh/custom/

echo -e "\033[1;33mConfig ssh...\033[0m"
mkdir -p ~/.ssh && cat /vagrant/config/authorized.key >> ~/.ssh/authorized_keys
sed -i 's/^#RSAAuthentication.*/RSAAuthentication\ yes/g' /etc/ssh/sshd_config
sed -i 's/^#PubkeyAuthentication.*/PubkeyAuthentication\ yes/g' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication.*/PasswordAuthentication\ yes/g' /etc/ssh/sshd_config

echo -e "\033[1;33mConfig dns...\033[0m"
cp /vagrant/config/resolv.conf /etc/

# echo -e "\033[1;33mUpdating kernel...\033[0m"
# rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
# rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
# yum --enablerepo=elrepo-kernel install  kernel-ml-devel kernel-ml -y
# grub2-set-default 0

echo -e "\033[1;33mInstall docker...\033[0m"
wget -qO- https://get.docker.com | sh
# curl -sSL https://get.daocloud.io/docker | sh

echo -e "\033[1;33mConfig docker registry mirrors...\033[0m"
mkdir -p /etc/docker && cp /vagrant/config/daemon.json /etc/docker/

echo -e "\033[1;33mStart and enable Docker...\033[0m"
systemctl enable docker
systemctl start docker

# echo -e "\033[1;33mVboxadd setup...\033[0m"
# cd /opt/VBoxGuestAdditions-*/init
# ./vboxadd setup