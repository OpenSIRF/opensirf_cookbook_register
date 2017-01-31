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

#include_recipe 'nfs::client4'
#
#%w(lv1 lv2).each do |lv|
#  directory "/var/lib/sirf/storage/nfs/devsirffs/#{lv}" do
#    action :create
#    recursive true
#  end
#
#  mount "#{lv}" do
#    device "devsirffs:/var/lib/sirf/storage/#{lv}"
#    mount_point "/var/lib/sirf/storage/nfs/devsirffs/#{lv}"
#  end
#end
