default['project_integration'] = {
  :jdk => {
    :name => 'JAVA',
    :home => '/usr/lib/jvm/java-7-openjdk-amd64'
  },
  :hudson_tasks_Maven_MavenInstallation => {
    :name => 'Maven',
    :home => '/usr/share/maven'
  },
  :auth_token => '<changeme>',
  :webhook_curl_notify => 'curl -X POST -k http://localhost:9101/v1/webhooks/stackstorm/notify -H &quot;X-Auth-Token: ',
  :webhook_jboss_provision => 'curl -X POST -k http://localhost:9101/v1/webhooks/stackstorm/chef/jbossprov1 -H &quot;X-Auth-Token: ',
  :webhook_docker_petclinic => 'curl -X POST -k http://localhost:9101/v1/webhooks/stackstorm/docker/petclinic -H &quot;X-Auth-Token: ',
  :petclinic_workspace => {
    :hudson_plugins_git_UserRemoteConfig => {
      :url => 'https://github.com/pandiarajann/Petclinic.git'
    },
    :hudson_plugins_git_BranchSpec => {
      :name => '*/master'
    },
    :hudson_tasks_Shell_started => {
      :command => '&quot; -H &quot;Content-Type: application/json&quot; --data &apos;{&quot;message&quot;: &quot;Petclinic project: Jenkins task Checkout started successfully.&quot;,&quot;jobname&quot;: &quot;Checkout&quot;}&apos;'
    },
    :hudson_tasks_Shell_completed => {
      :command => '&quot; -H &quot;Content-Type: application/json&quot; --data &apos;{&quot;message&quot;: &quot;Petclinic project: Jenkins task Checkout completed successfully.&quot;,&quot;jobname&quot;: &quot;Checkout&quot;}&apos;'
    }
  },
  :chef_provision => {
    :hudson_tasks_Shell_notify => {
      :command => '&quot; -H &quot;Content-Type: application/json&quot; --data &apos;{&quot;message&quot;: &quot;Petclinic project: Jboss provisioning by Chef has been started in vm1009.&quot;,&quot;jobname&quot;: &quot;Build&quot;}&apos;'
    },
    :hudson_tasks_Shell_chef_jbossprov => {
      :command => '&quot; -H &quot;Content-Type: application/json&quot; --data &apos;{&quot;message&quot;: &quot;Petclinic project: Jboss provisioning by Chef has been started in vm1009,pc1611 and pc1924.&quot;,&quot;jobname&quot;: &quot;Build&quot;}&apos;'
    }
  },
  :application_testing => {
    :hudson_tasks_Shell_completed => {
      :command => '&quot; -H &quot;Content-Type: application/json&quot; --data &apos;{&quot;message&quot;: &quot;Petclinic project: Local deployment to development box has been completed.&quot;,&quot;jobname&quot;: &quot;Deployment&quot;}&apos;'
    },
    :hudson_tasks_Shell_selenium_test => {
      :command => '&quot; -H &quot;Content-Type: application/json&quot; --data &apos;{&quot;message&quot;: &quot;Petclinic project: Selenium testing.&quot;,&quot;jobname&quot;: &quot;selenium&quot;}&apos;'
    }
  },
  :petclinic_build => {
    :root_pom => '/var/lib/jenkins/jobs/Petclinic-Workspace/workspace/pom.xml',
    :hudson_tasks_Shell_started => {
      :command => '&quot; -H &quot;Content-Type: application/json&quot; --data &apos;{&quot;message&quot;: &quot;Petclinic project: Jenkins task Build started successfully.&quot;,&quot;jobname&quot;: &quot;Build&quot;}&apos;'
    },
    :hudson_tasks_Shell_completed => {
      :command => '&quot; -H &quot;Content-Type: application/json&quot; --data &apos;{&quot;message&quot;: &quot;Petclinic project: Jenkins task Build completed successfully.&quot;,&quot;jobname&quot;: &quot;Build&quot;}&apos;'
    }
  },
  :petclinic_dev_local_deployment => {
    :hudson_tasks_Shell_notify => {
      :command => '&quot; -H &quot;Content-Type: application/json&quot; --data &apos;{&quot;message&quot;: &quot;Petclinic project: Local deployment to development box has been started.&quot;,&quot;jobname&quot;: &quot;Deployment&quot;}&apos;'
    },
    :hudson_plugins_deploy_tomcat_Tomcat7xAdapter => {
      :username => 'admin',
      :password => 'YWRtaW4=',
      :url => 'http://localhost:8081'
    }
  },
  :petclinic_docker_dev_deployment => {
    :hudson_tasks_Shell_deployment_completed => {
      :command => '&quot; -H &quot;Content-Type: application/json&quot; --data &apos;{&quot;message&quot;: &quot;Petclinic project: Local deployment to development box has been completed.&quot;,&quot;jobname&quot;: &quot;Deployment&quot;}&apos;'
    },
    :hudson_tasks_Shell_rebuilt_started => {
      :command => '&quot; -H &quot;Content-Type: application/json&quot; --data &apos;{&quot;message&quot;: &quot;Petclinic project: Re-build of docker container for petclinic using recently built petclinic.war has been started and this re-built container will be deployed to development box.&quot;,&quot;jobname&quot;: &quot;Deployment&quot;}&apos;'
    },
    :hudson_tasks_Shell_docker_kill => {
      :command => 'sudo docker kill petclinic &amp;&amp; sudo docker rm petclinic &amp;&amp; cd /var/lib/jenkins/jobs/Petclinic-Workspace/workspace/target &amp;&amp; sudo docker build -t devopsofs/petclinic . &amp;&amp; sudo docker run --name petclinic --add-host=dbhost:192.168.20.100 -p 8090:8080 -d devopsofs/petclinic'
    },
    :hudson_tasks_Shell_rebuilt_completed => {
      :command => '&quot; -H &quot;Content-Type: application/json&quot; --data &apos;{&quot;message&quot;: &quot;Petclinic project: Re-build and deployment of petclinic docker container to development box has been completed. This deployment is accessible on port 8090.&quot;,&quot;jobname&quot;: &quot;Deployment&quot;}&apos;'
    },
    :hudson_tasks_Shell_newbuild_pushed => {
      :command => '&quot; -H &quot;Content-Type: application/json&quot; --data &apos;{&quot;message&quot;: &quot;Petclinic project: Newly built docker container image for petclinic will be pushed to docker hub now.&quot;,&quot;jobname&quot;: &quot;Deployment&quot;}&apos;'
    },
    :hudson_tasks_Shell_notify_docker_push => {
      :command => 'sudo docker login --username=&quot;devopsofs&quot; --password=&quot;ofsatchennai&quot; --email=&quot;subramanian.mayakkaruppan@object-frontier.com&quot; &amp;&amp; sudo docker push devopsofs/petclinic'
    },
    :hudson_tasks_Shell_rebuilt_pushed => {
      :command => '&quot; -H &quot;Content-Type: application/json&quot; --data &apos;{&quot;message&quot;: &quot;Petclinic project: Re-built docker container image has been pushed to docker hub repository devops-ofs/petclinic&quot;,&quot;jobname&quot;: &quot;Deployment&quot;}&apos;'
    },
    :hudson_tasks_Shell_image_pulled => {
      :command => '&quot; -H &quot;Content-Type: application/json&quot; --data &apos;{&quot;message&quot;: &quot;Petclinic project: Recently pushed docker container image for petclinic will be pulled and deployed in QA server now.&quot;,&quot;jobname&quot;: &quot;Deployment&quot;}&apos;'
    }
  },
  :pull_petclinic_docker_image => {
    :hudson_tasks_Shell_notify_started => {
      :command => '&quot; -H &quot;Content-Type: application/json&quot; --data &apos;{&quot;message&quot;: &quot;Started&quot;,&quot;jobname&quot;: &quot;JBoss Provision&quot;}&apos;'
    }
  }
}
