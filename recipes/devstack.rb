#
# See LICENSE.md in the root directory.
#

directory '/var/lib/sirf' do
  action :create
end

yum_package 'java-1.8.0-openjdk-devel.x86_64'

tomcat_install '8'

remote_file '/opt/tomcat_8/webapps/opensirf-storage-monitor.war' do
  source node['storageMonitorUrl']
end

cookbook_file '/opt/tomcat_8/conf/server.xml' do
  source 'server_8088.xml'
  owner 'root'
  group 'root'
  mode '0644'
end

tomcat_service '8' do
  action :start
end

service "memcached" do
  action :start
end

execute 'swift_start' do
  command '/bin/swift-init start all'
end

execute 'swift_stat_test' do
  command "swift stat --os-username #{node['swift']['default_user']} --os-password #{node['swift']['default_pwd']} --os-auth-url #{node['swift']['ident_url']} --os-project-name #{node['swift']['project']}"
end
