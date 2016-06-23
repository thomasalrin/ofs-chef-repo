#
# Cookbook Name:: petclinic_project_integration
# Recipe:: petclinic_build
#
# Copyright 2015, OFS Technologies
#
# All rights reserved - Do Not Redistribute
#
cookbook_file '/var/lib/jenkins/jobs/Petclinic-Build.zip' do
  source 'Petclinic-Build.zip'
  action :create
end

bash 'unzip_job' do
  code <<-EOH
    sudo unzip /var/lib/jenkins/jobs/Petclinic-Build.zip -d /var/lib/jenkins/jobs/
    sudo rm -rf /var/lib/jenkins/jobs/Petclinic-Build.zip
  EOH
  not_if { ::File.exists?("/var/lib/jenkins/jobs/Petclinic-Build") }
end

template '/var/lib/jenkins/jobs/Petclinic-Build/config.xml' do
  source 'Petclinic-Build_config.xml.erb'
  action :create
end
