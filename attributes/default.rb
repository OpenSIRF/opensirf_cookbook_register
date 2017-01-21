default['swift']['default_pwd'] = '100years'
default['swift']['default_user'] = 'sirfadmin'
default['swift']['ident_url'] = 'http://devsirfswift:5000/v3'
default['swift']['project'] = 'sirf'

default['artifactRepo'] = 'http://200.144.189.109:58082/artifactory'
default['storageMonitorUri'] = 'org.opensirf/opensirf-storage-monitor/1.0.0/wars/opensirf-storage-monitor.war'
default['storageMonitorUrl'] = "#{node['artifactRepo']}/#{node['storageMonitorUri']}"

