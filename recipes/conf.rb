template '/var/lib/sirf/conf.json' do
  source 'conf.json.erb'
  owner 'tomcat_8'
  group 'tomcat_8'
  mode '0755'
end
