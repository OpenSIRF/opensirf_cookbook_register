sirf_server = node['opensirf_register']['conf']['server']

template '/var/lib/sirf/node.json' do
  source 'node.swift.json.erb'
end

bash 'sirf_register' do
  user 'root'
  code <<-EOH
    curl -i -X PUT -H "Content-Type:application/json" -d @/var/lib/sirf/node.json #{sirf_server}/elast/joinMultiConfiguration >> /var/lib/sirf/register.log
  EOH
end
