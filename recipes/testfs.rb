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

bash 'create_lvm_partition' do
  user 'root'
  code <<-EOH
    echo "n
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

