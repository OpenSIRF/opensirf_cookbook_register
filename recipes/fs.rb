#
# See LICENSE.md in the root directory.
#

directory '/var/lib/sirf/storage' do
  action :create
  recursive true
end

bash 'clean_lvm' do
  user 'root'
  returns [0, 5] # 5==VG doesn't exist
  code <<-EOH
    vgremove -f sirfvg
  EOH
end

bash 'create_lvm_partition' do
  user 'root'
  code <<-EOH
    echo "d
n
p
1


t
8e
w
"|sudo fdisk /dev/sdb;
    EOH
end

lvm_volume_group 'sirfvg' do
  physical_volumes '/dev/sdb1'
   
  %w(lv1 lv2).each do |lv|
      directory "/var/lib/sirf/storage/#{lv}" do
        action :create
      end
      logical_volume "#{lv}" do
        size '500m'
        filesystem 'ext3'
        mount_point "/var/lib/sirf/storage/#{lv}"
      end
   end
end

yum_package 'java-1.8.0-openjdk-devel.x86_64'

tomcat_install '8' 

remote_file '/opt/tomcat_8/webapps/opensirf-storage-monitor.war' do
  source node['storage_monitor_url']
end

tomcat_service '8' do
  action :start
end

