package 'tomcat7'

remote_directory '/opt/tomcat/conf' do
  owner 'tomcat'
  group 'tomcat'
  mode '0775'
  files_owner 'tomcat'
  files_group 'tomcat'
  files_mode '0644'
end

%w[/opt/tomcat7/conf/context.xml /opt/tomcat7/conf/server.xml /opt/tomcat7/conf/web.xml].each do |conffile|
  file conffile do
    mode '0660'
  end
end

remote_directory '/opt/tomcat7/bin' do
  source 'bin'
  owner 'tomcat'
  group 'tomcat'
  mode '0755'
end
