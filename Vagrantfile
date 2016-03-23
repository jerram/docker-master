# -*- mode: ruby -*-
# vi: set ft=ruby :

# please run:

# updates your hosts file with vm ipaddress
# vagrant plugin install vagrant-hostmanager

# caches apt packages on the host
# vagrant plugin install vagrant-cachier

# vagrant plugin install vagrant-vbguest


VAGRANTFILE_API_VERSION = "2"
HOSTNAME = 'docker-master.dev'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  config.vm.define HOSTNAME do |node|
    # node.hostmanager.aliases = %w(example-box.localdomain example-box-alias)
    node.vm.box      = 'ubuntu/trusty64'
    node.vm.hostname = HOSTNAME
    node.vm.synced_folder ".", "/vagrant", nfs: true
    node.vm.network "private_network", ip: "10.2.2.4"
    node.vm.provision :shell, :inline => "echo \"Etc/UTC\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"
  end

  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.name = HOSTNAME
    v.memory = 2048
    v.cpus = 2
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box

    # OPTIONAL: If you are using VirtualBox, you might want to use that to enable
    # NFS for shared folders. This is also very useful for vagrant-libvirt if you
    # want bi-directional sync
    config.cache.synced_folder_opts = {
      type: :nfs,
      # The nolock option can be useful for an NFSv3 client that wants to avoid the
      # NLM sideband protocol. Without this option, apt-get might hang if it tries
      # to lock files needed for /var/cache/* operations. All of this can be avoided
      # by using NFSv4 everywhere. Please note that the tcp option is not the default.
      mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    }
    # For more information please check http://docs.vagrantup.com/v2/synced-folders/basic_usage.html
  end

  # config.vm.provision "shell", path: "provision-server.sh", privileged: false
  # config.vm.provision "shell", path: "provision-dev.sh", privileged: false
  # config.vm.provision "shell", path: "provision-ruby.sh", privileged: false
  # config.vm.provision "shell", path: "provision-netball.sh", privileged: false
  # config.vm.provision "shell", inline: "service apache2 restart", run: "always"
#  config.vm.provision "shell", path: "provision-start-rails.sh", privileged: false, run: "always"


end
