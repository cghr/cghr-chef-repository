case node['platform_family']
  when 'debian'
    service 'apache2' do
      action :start
    end
  when 'rhel'
    service 'httpd' do
      action :start
    end
end
