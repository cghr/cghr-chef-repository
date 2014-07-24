package 'trac10'
package 'graphviz'
package 'python'

include_recipe 'cghr-server::apache-install'

remote_directory '/etc/trac' do
  files_owner 'root'
  files_group 'root'
  files_mode '0644'
  owner 'root'
  group 'root'
  mode '0755'
  source 'conf'
  purge true
  notifies :restart, 'service[httpd]', :delayed
end

directory node.default.trac.project_home do
  owner 'apache'
  group 'apache'
  mode '0755'
  action :create
end

template node.default.trac.digest_path do
  source 'htdigest'
  owner 'apache'
  group 'root'
  mode '0600'
end
