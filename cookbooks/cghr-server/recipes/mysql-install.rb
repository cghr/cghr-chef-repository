package 'mysql'
package 'mysql-server'

service 'mysqld' do
  action [:enable,:start]
end
