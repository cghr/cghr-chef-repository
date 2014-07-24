include_recipe 'cghr-server::python-install'
include_recipe 'cghr-server::trac-install'

trac_project_home_path = node.default.trac.project_home

node.default.trac.project.each do |project|
  project_id = project[1].id
  project_home_path = trac_project_home_path + '/' + project_id
  project_name = project[1].name
  project_descr = project[1].description
  project_conf_path = project_home_path + '/conf/trac.ini'
  project_db_path = project_home_path + '/db/trac.db'

  new = if File.exists?(project_db_path) then false else true end

  directory project_home_path do
    recursive true
    action :delete
    only_if { new }
  end

  execute :create_trac_project do
    user 'apache'
    command '/usr/bin/trac-admin ' + project_home_path + ' initenv "' + project_name + '" sqlite:db/trac.db'
    only_if { new }
  end

  remote_directory project_home_path do
    source 'root'
    owner 'apache'
    group 'apache'
    mode '0755'
    files_owner 'apache'
    files_group 'apache'
    files_mode '0755'
    recursive true
    action :create
  end

  template project_conf_path do
    source 'trac.ini.erb'
    variables ({
      :project_name => project_name,
      :project_descr => project_descr
    })
  end

  execute :make_admin do
    command '/usr/bin/trac-admin ' + project_home_path + ' permission add admin TRAC_ADMIN'
  end

  execute 'trac_project_upgrade' do
    command '/usr/bin/trac-admin ' + project_home_path + ' upgrade'
  end

  include_recipe 'trac-project-' + project_id + '::post-synchronize'
end

template '/etc/httpd/conf.d/trac.conf' do
  source 'trac.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[httpd]', :delayed
end

service 'httpd' do
  action :restart
end
