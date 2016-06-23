#
# Cookbook Name:: petclinic
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"

case node[:platform]

when 'ubuntu', 'debian'

#package "git"
package 'Install GIT' do
    package_name 'git'
end


=begin
#package "openjdk-7-jdk"
package 'Install JAVA' do
    package_name 'openjdk-7-jdk'
end


#package "maven"
package 'Install MAVEN' do
    package_name 'maven'
end

#Install tomcat
tomcat_install "#{node['tomcat']['name']}" do
  install_path "#{node['tomcat']['path']}"
  version "#{node['tomcat']['version']}"
end

=end

#Clone the petclinic code from github
git "#{node['petclinic']['repo']['location']}" do
  repository "#{node['petclinic']['repo']['url']}"
  revision "#{node['petclinic']['repo']['branch']}"
  action :sync
end

=begin
#Build package using maven
bash "Build Package" do
cwd "#{node['petclinic']['repo']['location']}"
  user "root"
   code <<-EOH
mvn clean
mvn package
  EOH
end


#Add project to tomcat
bash "Add project to tomcat" do
cwd "#{node['petclinic']['repo']['location']}"
  user "root"
   code <<-EOH
 cp ./target/*.war #{node['tomcat']['path']}/webapps/
  EOH
end

#start tomcat service
tomcat_service "#{node['tomcat']['name']}" do
  action :start
end

=end

end # Case node[:platform] End
