case node['platform_family']
  when 'rhel'
    include_recipe 'cghr-server::jdk-install'
    include_recipe 'cghr-server::tomcat-install'
end

# if icescrum does not exist, download the file to tmp folder

#remote_file '/tmp/icescrum.war.zip' do
#  source 'http://www.icescrum.org/downloads/icescrum_R6_13.2_war.zip'
#end

bash 'install_icescrum' do
  cwd '/tmp'
  code <<-EOL
  unzip -u /tmp/icescrum.war.zip -d /opt/tomcat7/webapps
  EOL
end

directory '/var/log/icescrum' do
  owner 'tomcat'
  group 'tomcat'
  mode '755'
end

directory '/etc/icescrum' do
  owner 'tomcat'
  group 'tomcat'
  mode '755'
end

include_recipe 'cghr-server::tomcat-restart'
