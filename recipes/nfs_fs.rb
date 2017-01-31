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
      nfs_export "/var/lib/sirf/storage/#{lv}" do
        network 'devsirfserver'
        writeable true
        options ['no_root_squash']
      end
   end
end

include_recipe 'nfs::server4'
