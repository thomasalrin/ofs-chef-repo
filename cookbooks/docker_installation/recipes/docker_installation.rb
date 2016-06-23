#
# Cookbook Name:: docker_installation
# Recipe:: docker_installation
#
# Copyright 2016, OFS Technologies
#
# All rights reserved - Do Not Redistribute
#
bash 'update_upgrade' do
  code <<-EOH
    sudo apt-get -y update
  EOH
end

bash 'install_linux_image_extra' do
  code <<-EOH
    sudo apt-get install linux-image-extra-`uname -r`
  EOH
end

bash 'update_dockerkey' do
  code <<-EOH
    sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list
    sudo apt-get update
  EOH
end

package 'docker-engine'

template '/etc/default/ufw' do
  source 'ufw.erb'
  action :create
end

bash 'update_firewall' do
  code <<-EOH
    sudo usermod -aG docker ${USER}
    sudo ufw reload
  EOH
end
