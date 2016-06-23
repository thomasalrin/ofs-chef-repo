#
# Cookbook Name:: petclinic_project_integration
# Recipe:: chef_provision
#
# Copyright 2015, OFS Technologies
#
# All rights reserved - Do Not Redistribute
#
cookbook_file '/var/lib/jenkins/jobs/Chef provision.zip' do
  source 'Chef provision.zip'
  action :create
end

bash 'unzip_job' do
  code <<-EOH
    sudo unzip "/var/lib/jenkins/jobs/Chef provision.zip" -d /var/lib/jenkins/jobs/
    sudo rm -rf "/var/lib/jenkins/jobs/Chef provision.zip"
  EOH
  not_if { ::File.exists?("/var/lib/jenkins/jobs/Chef provision") }
end

template '/var/lib/jenkins/jobs/Chef provision/config.xml' do
  source 'Chef-Provision_config.xml.erb'
  action :create
end
