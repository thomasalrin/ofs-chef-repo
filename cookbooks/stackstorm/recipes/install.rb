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

# Create an SSH system user (default `stanley` user may already exist)
# On StackStorm host, generate ssh keys
# Authorize key-based access
# Enable passwordless sudo
# Make sure `Defaults requiretty` is disabled in `/etc/sudoers`
bash 'Create Mistral DB in PostgreSQL' do
  code <<-EOH

sudo useradd stanley
sudo mkdir -p /home/stanley/.ssh
sudo chmod 0700 /home/stanley/.ssh

sudo ssh-keygen -f /home/stanley/.ssh/stanley_rsa -P ""

sudo sh -c 'cat /home/stanley/.ssh/stanley_rsa.pub >> /home/stanley/.ssh/authorized_keys'
sudo chown -R stanley:stanley /home/stanley/.ssh

sudo sh -c 'echo "stanley    ALL=(ALL)       NOPASSWD: SETENV: ALL" >> /etc/sudoers.d/st2'
sudo chmod 0440 /etc/sudoers.d/st2

sudo sed -i -r "s/^Defaults\s+\+requiretty/# Defaults +requiretty/g" /etc/sudoers

 EOH
end

execute 'Start services' do
  command 'sudo st2ctl start'
end


execute 'Register sensors and actions' do
  command 'st2ctl reload'
end


