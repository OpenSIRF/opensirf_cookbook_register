default['swift']['default_pwd'] = '100years'
default['swift']['default_user'] = 'sirfadmin'
default['swift']['ident_url'] = 'http://devsirfswift:5000/v3'
default['swift']['project'] = 'sirf'

default['artifact_repo'] = 'http://200.144.189.109:58082/artifactory'
default['storage_monitor_uri'] = 'org.opensirf/opensirf-storage-monitor/1.0.0/wars/opensirf-storage-monitor.war'
default['server_war_uri'] = 'org.opensirf/opensirf-server/1.0.0/wars/opensirf-server.war'
default['storage_monitor_url'] = "#{node['artifact_repo']}/#{node['storage_monitor_uri']}"
default['server_war_url'] = "#{node['artifact_repo']}/#{node['server_war_uri']}"

default['lv_size'] = '500m'
