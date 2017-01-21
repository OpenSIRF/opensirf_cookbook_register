#
# See LICENSE.md in the root directory.
#

directory '/var/lib/sirf' do
  action :create
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

# TODO: replace with LVM recipes
bash 'create_volumes' do
  user 'root'
  code <<-EOH
    pvcreate /dev/sdb1
    vgcreate sirfvg /dev/sdb1
    lvcreate -n lv1 -L #{node['lv_size']} sirfvg
    lvcreate -n lv2 -L #{node['lv_size']} sirfvg
   EOH
end

yum_package 'java-1.8.0-openjdk-devel.x86_64'

tomcat_install '8' 

remote_file '/opt/tomcat_8/webapps/opensirf-storage-monitor.war' do
  source node['storageMonitorUrl']
end

tomcat_service '8' do
  action :start
end

