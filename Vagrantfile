# -*- mode: ruby -*-
# vi: set ft=ruby :

iscsi_vdi0 = 'iscsi0.vdi'

Vagrant::Config.run do |config|

  config.vm.define :daisy do |storage_node|
    storage_node.vm.box = "Ubuntu lucid 32"
    storage_node.vm.box_url = "http://files.vagrantup.com/lucid32.box"

    storage_node.vm.customize ['createhd', '--filename', iscsi_vdi0, '--size', 10 * 1024]
    storage_node.vm.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', iscsi_vdi0]

    storage_node.vm.host_name = "daisy"
    storage_node.vm.network :hostonly, "192.168.122.114"
    storage_node.vm.network :hostonly, "192.168.133.114"

    storage_node.vm.forward_port 22, 22114

    storage_node.vm.provision :shell, :path => "provision.sh"

    storage_node.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.add_recipe "apt"
      chef.add_recipe "timezone"
      chef.add_recipe "ntp"
      chef.add_recipe "tgt"
    end
  end

  cluster_nodes = {
    :alice   => '111',
    :bob     => '112',
    :charlie => '113' 
  }

  cluster_nodes.each_pair do |node, ip_suffix|
    config.vm.define node do |cluster_node|
      cluster_node.vm.box = "Ubuntu lucid 32"
      cluster_node.vm.box_url = "http://files.vagrantup.com/lucid32.box"
      cluster_node.vm.network :hostonly, "192.168.122.#{ip_suffix}"
      cluster_node.vm.network :hostonly, "192.168.133.#{ip_suffix}"

      cluster_node.vm.forward_port 22, "22#{ip_suffix}".to_i

      cluster_node.vm.host_name = "#{node.to_s}"
      cluster_node.vm.provision :shell, :path => "provision.sh"

      cluster_node.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = "cookbooks"
        chef.add_recipe "apt"
        chef.add_recipe "timezone"
        chef.add_recipe "ntp"
        chef.add_recipe "lucid-ha-backports"
        chef.add_recipe "open-iscsi"
      end
    end
  end
end
