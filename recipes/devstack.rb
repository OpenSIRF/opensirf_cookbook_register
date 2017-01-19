#
# Cookbook Name:: opensirf_register
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

directory '/var/lib/sirf' do
  action :create
end

#template '/var/lib/sirf/conf.json' do
#  source 'multitest.conf.json.erb'
#end

yum_package 'java-1.8.0-openjdk-devel.x86_64'

tomcat_install '8'

remote_file '/opt/tomcat_8/webapps/opensirf-storage-monitor.war' do
  source 'http://200.144.189.109:58082/artifactory/org.opensirf/opensirf-storage-monitor/1.0.0/wars/opensirf-storage-monitor.war'
end

# Port 8080 is taken by Swift. Replacing tomcat's server.xml for storage monitor
cookbook_file '/opt/tomcat_8/conf/server.xml' do
  source 'server_8088.xml'
  owner 'root'
  group 'root'
  mode '0644'
end

tomcat_service '8' do
  action :start
end

