
```sh
➜ vagrant box add -f centos-7.2 centos-7.2.box

➜ cd base

➜ vagrant up # 执行 init.sh 脚本时，最好保证能够 fq

➜ vagrant package --output centos-7.2-ehlxr.box

➜ vagrant box add -f centos-7.2-ehlxr centos-7.2-ehlxr.box

```