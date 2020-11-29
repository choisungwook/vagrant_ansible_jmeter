INET = "jmeter"
IMAGE_NAME = "centos/7"
IP_MASTER = "192.168.219.199"
JMETER_MASTER = "192.168.219.200"
N = 1

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false

  # jmeter-master
  config.vm.define "jmeter" do |cfg|
    cfg.vm.box = IMAGE_NAME
    cfg.vm.network "public_network", ip: JMETER_MASTER
    cfg.vm.hostname = "jmeter"
    
    cfg.vm.provider "virtualbox" do |v|
      v.memory = 8192
      v.cpus = 1
      v.name = "jmeter"
    end
    cfg.vm.provision "shell", inline: <<-SCRIPT
      sed -i -e 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
      systemctl restart sshd
    SCRIPT

     # copy docker files
     cfg.vm.provision "file", source: "./dockerfiles", destination: "dockerfiles"
  end

  # ansible-server
  config.vm.define "ansible-server3" do |cfg|
    cfg.vm.box = IMAGE_NAME
    cfg.vm.hostname = "ansible-server-3"
    cfg.vm.network "public_network", ip: IP_MASTER

    cfg.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
      v.name =  "ansible-server-3"
    end
    cfg.vm.provision  "shell", inline: <<-SCRIPT
      yum install epel-release -y
      yum install python36 libselinux-python3 -y 
      yum install sshpass -y
      sudo pip3 install ansible
      sed -i -e 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
      systemctl restart sshd
    SCRIPT

    # copy ansible files
    cfg.vm.provision "file", source: "./install_ansible", destination: "install_ansible"
    cfg.vm.provision "shell", inline: "ansible-playbook ./install_ansible/add_hosts.yaml", privileged: false
    cfg.vm.provision "shell", inline: "ansible-playbook ./install_ansible/configure_ssh.yaml -i /home/vagrant/hosts", privileged: false

    # jmeter-master
    cfg.vm.provision "file", source: "./jmeter", destination: "jmeter"
    cfg.vm.provision "shell", inline: "ansible-playbook ./jmeter/site.yaml -i /home/vagrant/hosts", privileged: false
  end
end