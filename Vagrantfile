
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 1
  end

  # La VM principal haproxy, VM1: HAProxy + el Consul 
  config.vm.define "haproxy" do |h|
    h.vm.hostname = "haproxy-consul-srv"
    h.vm.network "private_network", ip: "10.10.0.10"
    h.vm.network "forwarded_port", guest: 80,   host: 8080, auto_correct: true
    h.vm.network "forwarded_port", guest: 8404, host: 8404, auto_correct: true
    h.vm.network "forwarded_port", guest: 8500, host: 8500, auto_correct: true

    h.vm.provision "shell", inline: <<-SHELL
      set -eux
      export DEBIAN_FRONTEND=noninteractive
      apt-get update -y
      apt-get install -y curl gnupg lsb-release ca-certificates unzip apt-transport-https software-properties-common
      # Para el Repo de HashiCorp mas los paquetes
      curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
      echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
      apt-get update -y
      apt-get install -y consul haproxy
    SHELL
  end

  # El Ayudante para nodos web
  def base_web(vm, ip)
    vm.vm.hostname = "web-#{ip.split('.').last}"
    vm.vm.network "private_network", ip: ip
    vm.vm.provision "shell", inline: <<-'SHELL'
      set -eux
      export DEBIAN_FRONTEND=noninteractive
      apt-get update -y
      apt-get install -y curl gnupg lsb-release ca-certificates unzip apt-transport-https software-properties-common
      # Con Node y Consul
      apt-get install -y nodejs npm
      curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
      echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
      apt-get update -y
      apt-get install -y consul
      # No arrancamos nada; se hará manualmente por SSH
    SHELL
  end

  config.vm.define "web1" do |w|
    base_web(w, "10.10.0.11")
  end

  config.vm.define "web2" do |w|
    base_web(w, "10.10.0.12")
  end
end
