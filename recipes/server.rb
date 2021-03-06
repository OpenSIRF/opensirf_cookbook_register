#
# See LICENSE.md in the root directory.
#

yum_package 'java-1.8.0-openjdk-devel.x86_64'

tomcat_install '8' 

remote_file '/opt/tomcat_8/webapps/ROOT.war' do
  source node['server_war_url']
end

directory '/var/lib/sirf' do
  action :create
  owner 'tomcat_opensirf'
  group 'tomcat_opensirf'
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

