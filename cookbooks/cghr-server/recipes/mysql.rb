package 'mysql'

package 'mysql-server'

template '/etc/my.cnf' do
  source '/mysql/my.cnf.erb'
  notifies :restart, 'service[mysqld]', :delayed
end

file '/etc/mysql/my.cnf' do
  action :delete
  notifies :restart, 'service[mysqld]', :delayed
end

file '/usr/etc/my.cnf' do
  action :delete
  notifies :restart, 'service[mysqld]', :delayed
end

file '~/.my.cnf' do
  action :delete
  notifies :restart, 'service[mysqld]', :delayed
end

service 'mysqld' do
  action [:enable, :start]
end
