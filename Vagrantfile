Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"
    config.ssh.forward_x11 = true
    config.vm.provision :shell, path: "bootstrap.sh"
    config.vm.network :forwarded_port, guest: 3000, host: 3000
    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 2
    end
end
