# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos7_base"
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.vm.synced_folder "./ood-home", "/home/ood", type: "virtualbox", mount_options: ["uid=1001","gid=1001"]
  config.vbguest.auto_update = false
  config.vm.define "ood", primary: true, autostart: true do |ood|
    ood.vm.network "forwarded_port", guest: 80, host: 8080
    ood.vm.network "private_network", ip: "192.168.56.100"
    ood.vm.provision "shell", inline: <<-SHELL
      yum install -y epel-release centos-release-scl lsof sudo
      sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
      sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-SCLo*
      sed -i 's|# baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-SCLo*
      yum install -y https://yum.osc.edu/ondemand/latest/ondemand-release-web-latest-1-2.el7.noarch.rpm
      yum install -y ondemand
    SHELL
    ood.vm.provision "shell", path: "ood-setup.sh"
    ood.vm.provision "shell", inline: "systemctl enable httpd24-httpd"
    ood.vm.provision "shell", inline: "systemctl start httpd24-httpd"
    ood.vm.provision "shell", inline: "hostnamectl set-hostname ood"
    ood.vm.provision "shell", inline: "cp -f /vagrant/hosts /etc/hosts"
    ood.vm.provision "shell", inline: "cp -f /vagrant/example.yml /etc/ood/config/clusters.d/example.yml"
    ood.vm.provision "shell", path: "slurm-setup.sh"
  end
  config.vm.define "head", primary: false, autostart: true do |head|
    head.vm.network "private_network", ip: "192.168.56.101"
    head.vm.provision "shell", path: "head-setup.sh"
    head.vm.provision "shell", inline: "hostnamectl set-hostname head"
    head.vm.provision "shell", inline: "cp -f /vagrant/hosts /etc/hosts"
    head.vm.provision "shell", path: "slurm-setup.sh"
    head.vm.provision "shell", inline: "systemctl enable slurmd"
    head.vm.provision "shell", inline: "systemctl start slurmd"
    head.vm.provision "shell", inline: "systemctl enable slurmctld"
    head.vm.provision "shell", inline: "systemctl start slurmctld"
  end
end

