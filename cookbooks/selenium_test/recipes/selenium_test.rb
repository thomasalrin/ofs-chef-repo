## Cookbook Name::  selenium_test
## Recipe:: selenium_test

## Copyright 2015, OFS Technologies

## All rights reserved - Do Not Redistribute

package "xvfb"

directory '/usr/local/dev/' do
  action :create
end

cookbook_file '/usr/local/dev/Petclinic-test.zip' do
  source 'Petclinic-test.zip'
  action :create
end

bash 'copy_project' do
  code <<-EOH
    unzip /usr/local/dev/Petclinic-test.zip -d /usr/local/dev/
    rm -f /usr/local/dev/Petclinic-test.zip
  EOH
end

template '/usr/local/dev/Petclinic-test/resource/DefaultConstants.properties' do
  source 'DefaultConstants.properties.erb'
  action :create
end

bash 'run_test' do
  code <<-EOH
    sudo ./usr/local/dev/Petclinic-test/testrun.sh
  EOH
end

