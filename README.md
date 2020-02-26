
# Vagrant

```shell
# 插件安装
➜ vagrant plugin install vagrant-vbguest
➜ vagrant plugin install vagrant-hosts
```

```sh
➜ cd base

➜ wget https://www.dropbox.com/s/570sb9j9k6b9rpp/centos-7.5-ehlxr.box?dl=0 -O centos-7.5-ehlxr.box

➜ vagrant box add -f centos-7.5-ehlxr centos-7.5-ehlxr.box

➜ vagrant up # 执行 init.sh 脚本时，最好保证能够 fq

➜ vagrant package --output centos-7.5-ehlxr.box

➜ vagrant box add -f centos-7.5-ehlxr centos-7.5-ehlxr.box

```

```sh
# onedrive.live.com、drive.google.com、pan.baidu.com 下载 centos-7.5-ehlxr

➜ vagrant box add -f centos-7.5-ehlxr centos-7.5-ehlxr.box
# vagrant package --base vghost1 --output centos-ehlxr.box

➜ vagrant up # 执行 init.sh 脚本时，最好保证能够 fq

```

## vagrant plugin install 超时解决方法

```sh
➜ gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/

➜ gem sources -l
# 确保只有 gems.ruby-china.com

➜ vagrant plugin install vagrant-vbguest --plugin-clean-sources --plugin-source https://gems.ruby-china.com/
```