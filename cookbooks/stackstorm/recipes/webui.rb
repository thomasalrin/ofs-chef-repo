#UI Install
# Add key and repo for the latest stable nginx
execute "Add webui st2 key" do
 command "sudo apt-key adv --fetch-keys http://nginx.org/keys/nginx_signing.key"
end

bash 'Add sources.list entry' do
  code <<-EOH
sudo sh -c "cat <<EOT > /etc/apt/sources.list.d/nginx.list
deb http://nginx.org/packages/ubuntu/ trusty nginx
deb-src http://nginx.org/packages/ubuntu/ trusty nginx
EOT"
  EOH
end

execute "Update webui st2 packages" do
 command "apt-get update"
end


# Install st2web and nginx
# note nginx should be > 1.4.6. To install a new version like 1.10.1 do "sudo apt-get install -y nginx=1.10.1-1~trusty"
package 'Install st2 webui' do
  package_name [ "st2web", "nginx"]
end

# Generate self-signed certificate or place your existing certificate under /etc/ssl/st2
directory '/etc/ssl/st2' do
  action :create
end

bash 'Add st2 certificate' do
  code <<-EOH
sudo openssl req -x509 -newkey rsa:2048 -keyout /etc/ssl/st2/st2.key -out /etc/ssl/st2/st2.crt \
-days XXX -nodes -subj "/C=US/ST=California/L=Palo Alto/O=StackStorm/OU=Information \
Technology/CN=$(hostname)"
  EOH
end

# Remove default site, if present
execute "Remove default site, if present" do
 command "rm /etc/nginx/conf.d/default.conf"
end

# Copy and enable StackStorm's supplied config file
execute "Copy and enable StackStorm's supplied config file" do
 command "cp /usr/share/doc/st2/conf/nginx/st2.conf /etc/nginx/conf.d/"
end

service "nginx" do
  supports [:stop, :start, :restart]
  action [:start, :enable]
  action [:restart]
end


