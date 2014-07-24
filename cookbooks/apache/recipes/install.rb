case node['platform_family']
when 'rhel'
  package 'httpd'
when 'debian'
  package 'apache2'
end

package 'mod_python'

remote_directory '/etc/httpd/conf' do
  source 'conf/conf'
  owner 'root'
  group 'root'
  mode '0755'
  files_owner 'root'
  files_group 'root'
  files_mode '0644'
  purge true
  action :create
end

remote_directory '/etc/httpd/conf.d' do
  source 'conf/conf.d'
  owner 'root'
  group 'root'
  mode '0755'
  files_owner 'root'
  files_group 'root'
  files_mode '0644'
  purge true
  action :create
end

include_recipe 'apache::enable'
include_recipe 'apache::start'
