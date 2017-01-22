#
# See LICENSE.md in the root directory.
#

directory '/var/lib/sirf' do
  action :create
end

yum_package 'java-1.8.0-openjdk-devel.x86_64'

tomcat_install '8' 

remote_file '/opt/tomcat_8/webapps/ROOT.war' do
  source node['server_war_url']
end

tomcat_service '8' do
  action :start
end

