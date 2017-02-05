include_recipe 'nfs::client4'

%w(lv1 lv2).each do |lv|
  directory "/var/lib/sirf/storage/nfs/devsirffs/#{lv}" do
    action :create
    owner 'tomcat_8'
    group 'tomcat_8'
    recursive true
  end

  mount "#{lv}" do
    device "devsirffs:/var/lib/sirf/storage/#{lv}"
    mount_point "/var/lib/sirf/storage/nfs/devsirffs/#{lv}"
  end
end

execute "chown-data-sirf" do
  command "chown -R tomcat_8:tomcat_8 /var/lib/sirf"
  user "root"
end

