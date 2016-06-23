default['jenkins'] = {
  :NAME => 'jenkins',
  :JAVA => '/usr/bin/java',
  :JAVA_ARGS =>'"-Djava.awt.headless=true"',
  :PIDFILE => '/var/run/$NAME/$NAME.pid',
  :JENKINS_USER => '$NAME',
  :JENKINS_GROUP => '$NAME',
  :JENKINS_WAR => '/usr/share/$NAME/$NAME.war',
  :JENKINS_HOME => '/var/lib/$NAME',
  :RUN_STANDALONE => 'true',
  :JENKINS_LOG => '/var/log/$NAME/$NAME.log',
  :MAXOPENFILES => '8192',
  :HTTP_PORT => '9090',
  :AJP_PORT => '-1',
  :PREFIX => '/$NAME',
  :JENKINS_ARGS => '"--webroot=/var/cache/$NAME/war --httpPort=$HTTP_PORT --ajp13Port=$AJP_PORT"'
}
