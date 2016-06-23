#
# Cookbook Name:: petclinic_project_integration
# Recipe:: application_testing
#
# Copyright 2015, OFS Technologies
#
# All rights reserved - Do Not Redistribute
#
cookbook_file '/var/lib/jenkins/jobs/ApplicationTesting.zip' do
  source 'ApplicationTesting.zip'
  action :create
end

bash 'unzip_job' do
  code <<-EOH
    sudo unzip /var/lib/jenkins/jobs/ApplicationTesting.zip -d /var/lib/jenkins/jobs/
    sudo rm -rf /var/lib/jenkins/jobs/ApplicationTesting.zip
  EOH
  not_if { ::File.exists?("/var/lib/jenkins/jobs/ApplicationTesting") }
end

template '/var/lib/jenkins/jobs/ApplicationTesting/config.xml' do
  source 'Application-Testing_config.xml.erb'
  action :create
end
