#
# Cookbook Name:: jenkins
# Recipe:: jenkins
#
# Copyright 2015, OFS Technologies
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apt"

bash 'update_reconfigure' do
  code <<-EOH
    sudo apt-get update
    sudo dpkg --configure -a
  EOH
end

package "openjdk-7-jre"

package "openjdk-7-jdk"

apt_repository "jenkins" do
  uri "http://pkg.jenkins-ci.org/debian"
  key "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"
  components ["binary/"]
  action :add
end

package "jenkins"

template '/etc/default/jenkins' do
  source 'jenkins.erb'
  action :create
end

service "jenkins" do
  supports [:stop, :start, :restart]
  action [:start, :enable]
  action [:restart]
end



