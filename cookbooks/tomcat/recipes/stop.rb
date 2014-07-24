bash 'stop_tomcat' do
  code <<-EOL
    /opt/tomcat7/bin/shutdown.sh
  EOL
end
