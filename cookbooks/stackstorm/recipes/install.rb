include_recipe "apt"

package 'Install dependencies' do
  package_name [ "mongodb-server", "rabbitmq-server", "postgresql"]
end

execute "curl -s https://packagecloud.io/install/repositories/StackStorm/stable/script.deb.sh | sudo bash"

package 'Install Stackstorm' do
  package_name [ "st2", "st2mistral"]
end

# Create Mistral DB in PostgreSQL
bash 'Create Mistral DB in PostgreSQL' do
  code <<-EOH
cat << EHD | sudo -u postgres psql
CREATE ROLE mistral WITH CREATEDB LOGIN ENCRYPTED PASSWORD 'StackStorm';
CREATE DATABASE mistral OWNER mistral;
EHD
  EOH
end

execute 'Setup Mistral DB tables' do
  command '/opt/stackstorm/mistral/bin/mistral-db-manage --config-file /etc/mistral/mistral.conf upgrade head'
end

execute 'Register mistral actions' do
  command '/opt/stackstorm/mistral/bin/mistral-db-manage --config-file /etc/mistral/mistral.conf populate'
end

