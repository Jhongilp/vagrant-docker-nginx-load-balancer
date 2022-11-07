Vagrant.configure("2") do |config|
  if Vagrant.has_plugin? "vagrant-vbguest"
    config.vbguest.no_install  = true
    config.vbguest.auto_update = false
    config.vbguest.no_remote   = true
  end

  config.vm.provision "shell", inline: $script

  # node.js server1
  config.vm.define :vm1 do |vm1|
    vm1.vm.box = "bento/ubuntu-20.04"
    vm1.vm.network :private_network, ip: "192.168.100.3"
    vm1.vm.hostname = "vm1"
  end

  # node.js server2
  config.vm.define :vm2 do |vm2|
    vm2.vm.box = "bento/ubuntu-20.04"
    vm2.vm.network :private_network, ip: "192.168.100.4"
    vm2.vm.hostname = "vm2"
  end

  # nginx load balancer
  config.vm.define :vm3 do |vm3|
    vm3.vm.box = "bento/ubuntu-20.04"
    vm3.vm.network :private_network, ip: "192.168.100.5"
    vm3.vm.hostname = "vm3"
  end
  
end