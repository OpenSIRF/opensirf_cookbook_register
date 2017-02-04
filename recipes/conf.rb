template '/var/lib/sirf/conf.json' do
  source 'conf.json.erb'
  owner 'root'
  group 'root'
  mode '0755'
end
