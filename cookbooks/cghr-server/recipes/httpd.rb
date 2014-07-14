package 'httpd'

remote_directory '/etc/httpd/conf' do
  source 'httpd/conf'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[httpd]', :delayed
end

remote_directory '/etc/httpd/conf.d' do
  source 'httpd/conf.d'
  owner 'root'
  group 'root'
  mode '0755'
end

file '/etc/httpd/conf/httpd.conf' do
  owner 'root'
  group 'root'
  mode '0640'
  notifies :restart, 'service[httpd]', :delayed
end

file '/etc/httpd/conf/magic' do
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[httpd]', :delayed
end

%w[/etc/httpd/conf/ssl.key /etc/httpd/conf/ssl.crt].each do |sslfile|
  remote_directory sslfile do
    source 'httpd/conf/' << sslfile.split('/').last
    owner 'root'
    group 'root'
    mode '0700'
    notifies :restart, 'service[httpd]', :delayed
  end
end

%w[/etc/httpd/conf/ssl.prm /etc/httpd/conf/ssl.csr /etc/httpd/conf/ssl.crl].each do |sslfile|
  directory sslfile do
    owner 'root'
    group 'root'
    mode '0700'
    notifies :restart, 'service[httpd]', :delayed
  end
end

%w[/etc/httpd/conf.d/welcome.conf.disable /etc/httpd/conf.d/secure.conf /etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/python.conf /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/ssl.conf.rpmnew /etc/httpd/conf.d/README /etc/httpd/conf.d/proxy_ajp.conf /etc/httpd/conf.d/subversion.conf /etc/httpd/conf.d/php.conf].each do |conffile|
  file conffile do
    owner 'root'
    group 'root'
    mode '0644'
    notifies :restart, 'service[httpd]', :delayed
  end
end

service 'httpd' do
  action [:enable, :start]
end
