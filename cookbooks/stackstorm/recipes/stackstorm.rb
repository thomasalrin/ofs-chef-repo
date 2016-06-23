#
# Cookbook Name:: stackstorm
# Recipe:: stackstorm
#
# Copyright 2015, OFS Technologies
#
# All rights reserved - Do Not Redistribute
#
cookbook_file '/usr/local/st2_deploy.sh' do
  source 'st2_deploy.sh'
  action :create
end

bash 'install_authenticate' do
  code <<-EOH
    sudo chmod +x /usr/local/st2_deploy.sh
    sudo /usr/local/st2_deploy.sh
  EOH
  not_if { ::File.exists?("/etc/st2/st2.conf") }
end

bash 'install_packs' do
  code <<-EOH
    st2 run packs.install packs=chef,jenkins,slack repo_url=https://github.com/StackStorm/st2contrib.git
  EOH
end

cookbook_file '/opt/stackstorm/packs/petclinic.zip' do
  source 'petclinic.zip'
  action :create
end

bash 'unzip_petclinic' do
  code <<-EOH
    unzip /opt/stackstorm/packs/petclinic.zip -d /opt/stackstorm/packs/
    rm -f /opt/stackstorm/packs/petclinic.zip
  EOH
end

template '/opt/stackstorm/packs/slack/config.yaml' do
  source 'config.yaml.erb'
  action :create
end

bash 'restart_stackstorm' do
  code <<-EOH
    sudo WEBUI_PORT=8082 st2ctl restart
    sudo kill `sudo lsof -t -i:8080`
  EOH
end

bash 'reload_all_packs' do
  code <<-EOH
    sudo st2ctl reload --register-all
  EOH
end

