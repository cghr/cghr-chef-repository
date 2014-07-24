case node['platform_family']
  when 'debian'
    service 'apache2' do
      action :enable
    end
  when 'rhel'
    service 'httpd' do
      action :enable
    end
end
