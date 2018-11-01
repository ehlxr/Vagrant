Vagrant.configure("2") do |config|
    # 定义虚拟机数量
    vms = Array(1..5)
    vms.each do |i|
        config.vm.define "vg#{i}" do |cfg|
            # 设置虚拟机的 Box
            cfg.vm.box = "centos-7.2-ehlxr"

            # 不检查 box 更新
            cfg.vm.box_check_update = false
            # 设置虚拟机的主机名
            cfg.vm.hostname="vg#{i}.node"
            # cfg.vm.network "forwarded_port", guest: 80, host: 8080

            # hostonly
            cfg.vm.network "private_network", ip: "192.168.3.10#{i}",:auto_network => true
            # bridged
            # cfg.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"

            cfg.vm.provider "virtualbox" do |vb|
                # Display the VirtualBox GUI when booting the machine
                vb.gui = false

                # Customize the amount of memory on the VM:
                vb.memory = "1024"

                vb.cpus = 1

                # 名称指的是在 VirtualBox 中显示的名称
                vb.name = "vghost#{i}"
            end

            # 增加各节点 host 配置（插件安装：vagrant plugin install vagrant-hosts）
            cfg.vm.provision :hosts do |provisioner|
                vms.each do |x|
                    provisioner.add_host "192.168.3.10#{x}", ["vg#{x}.node"]
                end
            end

            # 默认 root 登陆
            cfg.ssh.username = "root"
            cfg.ssh.password = "vagrant"
            cfg.ssh.insert_key = "true"

            # do NOT check the correct additions version when booting this machine（插件安装：vagrant plugin install vagrant-vbguest）
            cfg.vbguest.auto_update = false

            cfg.vm.synced_folder "/Users/ehlxr/works/Vagrant/vm_share", "/share"
            cfg.vm.synced_folder "/Users/ehlxr/works/Vagrant", "/vagrant"

            # 开机运行命令
            # cfg.vm.provision "shell", run: "always", inline: <<-SHELL
            #     echo -e "\033[1;33mInit cmd...\033[0m"
            #     echo -e "\033[1;33mConfig ssh...\033[0m"
            #     mkdir -p ~/.ssh && cat /vagrant/config/authorized.key >> ~/.ssh/authorized_keys
            #     sed -i 's/^#RSAAuthentication.*/RSAAuthentication\ yes/g' /etc/ssh/sshd_config
            #     sed -i 's/^#PubkeyAuthentication.*/PubkeyAuthentication\ yes/g' /etc/ssh/sshd_config
            #     sed -i 's/^PasswordAuthentication.*/PasswordAuthentication\ yes/g' /etc/ssh/sshd_config
            # SHELL

            # 自定义初始化执行脚本
            # cfg.vm.provision "shell", path: "config/init.sh"
        end
    end
end