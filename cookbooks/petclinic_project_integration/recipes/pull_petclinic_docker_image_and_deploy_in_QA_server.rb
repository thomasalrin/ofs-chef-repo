cookbook_file '/var/lib/jenkins/jobs/Pull petclinic docker image and deploy in QA server.zip' do
  source 'Pull petclinic docker image and deploy in QA server.zip'
  action :create
end

bash 'unzip_job' do
  code <<-EOH
    sudo unzip "/var/lib/jenkins/jobs/Pull petclinic docker image and deploy in QA server.zip" -d /var/lib/jenkins/jobs/
    sudo rm -rf "/var/lib/jenkins/jobs/Pull petclinic docker image and deploy in QA server.zip"
  EOH
  not_if { ::File.exists?("/var/lib/jenkins/jobs/Pull petclinic docker image and deploy in QA server") }
end

template '/var/lib/jenkins/jobs/Pull petclinic docker image and deploy in QA server/config.xml' do
  source 'Pull-Petclinic-Docker-Image-And-Deploy-In-QA-Server_config.xml.erb'
  action :create
end
