#
# Cookbook Name:: petclinic_project_integration
# Recipe:: petclinic_workspace
#
# Copyright 2015, OFS Technologies
#
# All rights reserved - Do Not Redistribute
#
cookbook_file '/var/lib/jenkins/jobs/Petclinic-Workspace.zip' do
  source 'Petclinic-Workspace.zip'
  action :create
end

bash 'unzip_job' do
  code <<-EOH
    sudo unzip /var/lib/jenkins/jobs/Petclinic-Workspace.zip -d /var/lib/jenkins/jobs/
    sudo rm -rf /var/lib/jenkins/jobs/Petclinic-Workspace.zip
  EOH
  not_if { ::File.exists?("/var/lib/jenkins/jobs/Petclinic-Workspace") }
end

template '/var/lib/jenkins/jobs/Petclinic-Workspace/config.xml' do
  source 'Petclinic-Workspace_config.xml.erb'
  action :create
end
