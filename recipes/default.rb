#
# Cookbook Name:: opensirf_register
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

directory '/var/lib/sirf' do
  action :create
end

template '/var/lib/sirf/conf.json' do
  source 'conf.json.erb'
end

