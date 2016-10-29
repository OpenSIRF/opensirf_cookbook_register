#
# Cookbook Name:: opensirf_register
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

directory '/var/lib/sirf' do
  action :create
end

template '/var/lib/sirf/conf.json' do
  source 'multitest.conf.json.erb'
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

bash 'create_volumes' do
  user 'root'
  code <<-EOH
    pvcreate /dev/sdb1
    vgcreate sirfvg /dev/sdb1
    lvcreate -n lv1 -L 500m sirfvg
    lvcreate -n lv2 -L 500m sirfvg
   EOH
end

yum_package 'java-1.8.0-openjdk-devel.x86_64'

tomcat_install '8' 

remote_file '/opt/tomcat_8/webapps/ROOT.war' do
  source 'http://200.144.189.109:58082/artifactory/org.opensirf/opensirf-storage-monitor/1.0.0/wars/opensirf-storage-monitor.war'
end

tomcat_service '8' do
  action :start
end

