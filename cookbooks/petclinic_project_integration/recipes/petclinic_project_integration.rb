#
# Cookbook Name:: petclinic_project_integration
# Recipe:: petclinic_project_integration
#
# Copyright 2015, OFS Technologies
#
# All rights reserved - Do Not Redistribute
#
package 'maven' do
  action :install
  options '--force-yes'
end

cookbook_file '/usr/local/jenkins-cli.jar' do
  source 'jenkins-cli.jar'
  action :create
end

bash 'install_plugins' do
  code <<-EOH
    sudo apt-get clean all
    sudo java -jar /usr/local/jenkins-cli.jar -s http://localhost:9090/ install-plugin git github authentication-tokens bootstraped-multi-test-results-report build-monitor-plugin build-pipeline-plugin deploy downstream-buildview extreme-notification htmlpublisher jquery notification parameterized-trigger testng-plugin workflow-step-api xvnc xvfb
  EOH
  not_if { ::File.exists?("/var/lib/jenkins/plugins/git.jpi") &&
           ::File.exists?("/var/lib/jenkins/plugins/github.jpi") &&
           ::File.exists?("/var/lib/jenkins/plugins/authentication-tokens.jpi") &&
           ::File.exists?("/var/lib/jenkins/plugins/bootstraped-multi-test-results-report.jpi") &&
           ::File.exists?("/var/lib/jenkins/plugins/build-monitor-plugin.jpi") &&
           ::File.exists?("/var/lib/jenkins/plugins/build-pipeline-plugin.jpi") &&
           ::File.exists?("/var/lib/jenkins/plugins/deploy.jpi") &&
           ::File.exists?("/var/lib/jenkins/plugins/downstream-buildview.jpi") &&
           ::File.exists?("/var/lib/jenkins/plugins/extreme-notification.jpi") &&
           ::File.exists?("/var/lib/jenkins/plugins/htmlpublisher.jpi") &&
           ::File.exists?("/var/lib/jenkins/plugins/jquery.jpi") &&
           ::File.exists?("/var/lib/jenkins/plugins/notification.jpi") &&
           ::File.exists?("/var/lib/jenkins/plugins/parameterized-trigger.jpi") &&
           ::File.exists?("/var/lib/jenkins/plugins/testng-plugin.jpi") &&
           ::File.exists?("/var/lib/jenkins/plugins/workflow-step-api.jpi") &&
           ::File.exists?("/var/lib/jenkins/plugins/xvnc.jpi") &&
           ::File.exists?("/var/lib/jenkins/plugins/xvfb.jpi") }
end

ruby_block "assign_token" do
    block do
        #tricky way to load this Chef::Mixin::ShellOut utilities
        Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)      
        command = 'st2 auth testu -p testp -t'
        command_out = shell_out(command)
        string_out = command_out.stdout
        node.override['project_integration']['auth_token'] = string_out.gsub(/\n/,"")
    end
    action :run
end

service "jenkins" do
  action [:stop]
end

include_recipe "petclinic_project_integration::petclinic_workspace"
include_recipe "petclinic_project_integration::petclinic_build"
include_recipe "petclinic_project_integration::petclinic_dev_local_deployment"
include_recipe "petclinic_project_integration::petclinic_docker_dev_deployment"
include_recipe "petclinic_project_integration::application_testing"
include_recipe "petclinic_project_integration::chef_provision"
include_recipe "petclinic_project_integration::pull_petclinic_docker_image_and_deploy_in_QA_server"

template '/var/lib/jenkins/config.xml' do
  source 'sys_config.xml.erb'
  action :create
end

template '/var/lib/jenkins/hudson.tasks.Maven.xml' do
  source 'hudson.tasks.Maven.xml.erb'
  action :create
end

data_item = data_bag_item("git_authentication", "pandiarajann")

template '/var/lib/jenkins/credentials.xml' do
  source 'credentials.xml.erb'
  variables(
    :username => data_item["username"],
    :password => data_item["password"]
  )
  action :create
end

bash 'change_users' do
  code <<-EOH
    sudo chown -R jenkins /var/lib/jenkins/jobs/Petclinic-Workspace
    sudo chown -R jenkins /var/lib/jenkins/jobs/ApplicationTesting
    sudo chown -R jenkins "/var/lib/jenkins/jobs/Chef provision"
    sudo chown -R jenkins /var/lib/jenkins/jobs/Petclinic-Dev-Local-Deployment
    sudo chown -R jenkins /var/lib/jenkins/jobs/Petclinic-Docker-Dev-Deployment
    sudo chown -R jenkins "/var/lib/jenkins/jobs/Pull petclinic docker image and deploy in QA server"
    sudo chown -R jenkins /var/lib/jenkins/jobs/Petclinic-Build

    sudo chgrp -R jenkins /var/lib/jenkins/jobs/Petclinic-Workspace
    sudo chgrp -R jenkins /var/lib/jenkins/jobs/ApplicationTesting
    sudo chgrp -R jenkins "/var/lib/jenkins/jobs/Chef provision"
    sudo chgrp -R jenkins /var/lib/jenkins/jobs/Petclinic-Dev-Local-Deployment
    sudo chgrp -R jenkins /var/lib/jenkins/jobs/Petclinic-Docker-Dev-Deployment
    sudo chgrp -R jenkins "/var/lib/jenkins/jobs/Pull petclinic docker image and deploy in QA server"
    sudo chgrp -R jenkins /var/lib/jenkins/jobs/Petclinic-Build
  EOH
end

service "jenkins" do
  action [:start]
end
