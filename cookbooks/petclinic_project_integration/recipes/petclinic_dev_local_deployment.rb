#
# Cookbook Name:: petclinic_project_integration
# Recipe:: petclinic_dev_local_deployment
#
# Copyright 2015, OFS Technologies
#
# All rights reserved - Do Not Redistribute
#
cookbook_file '/var/lib/jenkins/jobs/Petclinic-Dev-Local-Deployment.zip' do
  source 'Petclinic-Dev-Local-Deployment.zip'
  action :create
end

bash 'unzip_job' do
  code <<-EOH
    sudo unzip /var/lib/jenkins/jobs/Petclinic-Dev-Local-Deployment.zip -d /var/lib/jenkins/jobs/
    sudo rm -rf /var/lib/jenkins/jobs/Petclinic-Dev-Local-Deployment.zip
  EOH
  not_if { ::File.exists?("/var/lib/jenkins/jobs/Petclinic-Dev-Local-Deployment") }
end

template '/var/lib/jenkins/jobs/Petclinic-Dev-Local-Deployment/config.xml' do
  source 'Petclinic-Dev-Local-Deployment_config.xml.erb'
  action :create
end
