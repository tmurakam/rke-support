# -*- mode: ruby -*-
# vi: set ft=ruby :

ssh_script = <<EOS
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
EOS

Vagrant.configure("2") do |config|
  config.vm.box = "bento/almalinux-8" # AlmaLinux 8
  #config.vm.box = "generic/ubuntu2004" # Ubuntu 20.04

  # config.vm.box_check_update = false

  config.vm.network "private_network", ip: "192.168.33.111"

  # disk size
  #config.disksize.size = '100GB'

  # Mount dsa-installer to home directory
  config.vm.synced_folder "./", "/home/vagrant/rke-support", "owner": "vagrant", "group": "vagrant"

  # VM spec
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 8
    vb.memory = "16384"
  end

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.enabled  = true
    config.proxy.http     = "#{ENV['http_proxy']}"
    config.proxy.https    = "#{ENV['https_proxy']}"
    config.proxy.no_proxy = "#{ENV['no_proxy']},192.168.33.111"
  end

  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = true
    config.vbguest.no_remote = true
  end

  config.vm.provision :vagrant_user, type: "shell", privileged: false, :inline => ssh_script
end
