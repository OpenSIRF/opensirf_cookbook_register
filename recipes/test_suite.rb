git '/var/lib/sirf/test' do
  repository "#{node['gitrepo']}/opensirf-test-suite"
  action :checkout
end

execute 'run_tests' do
  cwd '/var/lib/sirf/test'
  command 'sbt test'
end

