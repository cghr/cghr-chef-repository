case node['platform_family']
  when 'debian'
    service 'apache2' do
      action :stop
    end
  when 'rhel'
    service 'httpd' do
      action :stop
    end
end
