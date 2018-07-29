#
# Cookbook:: tractor
# Recipe:: blade
#
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

include_recipe "tractor::default"

tractor_user = node['tractor']['user']['name']
tractor_home = node['tractor']['home']

# Find the engine
if node['tractor']['engine']['address'].nil?
  engines = cluster.search(:clusterUID => node['cyclecloud']['cluster']['id']).select {|n| not n['tractor']['is_engine'].nil? and n['tractor']['is_engine'] == true}.map  do |n|
    n['cyclecloud']['instance']['ipv4']
  end
  if engines.length < 1
    raise Exception, "No Tractor Engine discovered."
  end
  node.default['tractor']['engine']['address'] = engines[0]
  node.override['tractor']['engine']['address'] = engines[0]
end
Chef::Log.info "Tractor Engine: #{node['tractor']['engine']['address']}"


blade_options = node['tractor']['blade']['cmd_options'] || ""
if blade_options =~ /--engine /
  Chef::Log.warn "Tractor engine overriden in OTPTIONS (ignoring tractor.engine.address and tractor.engine.port) : #{blade_options}"
else
  blade_options += " --engine #{node['tractor']['engine']['address']}:#{node['tractor']['engine']['port']}"
end

node.default['tractor']['blade']['cmd_options'] = blade_options
node.override['tractor']['blade']['cmd_options'] = blade_options

# Setup Blade service
directory '/etc/systemd/system/tractor-blade.service.d' do
  recursive true
end

# Setup Blade service
template "/etc/systemd/system/tractor-blade.service.d/90-tractor-blade-overrides.conf" do
  source "90-tractor-blade-overrides.conf.erb"
end


template "/etc/sysconfig/tractor-blade" do
  source "tractor-blade.erb"
end

bash "create Blade service" do
  code <<-EOH
  cp #{tractor_home}/lib/SystemServices/systemd/tractor-blade.service  /usr/lib/systemd/system/tractor-blade.service
  EOH
  creates '/usr/lib/systemd/system/tractor-blade.service'
end


defer_block 'Defer start of Tractor Blade until end of converge to ensure node is ready for jobs' do
  service 'tractor-blade' do
    action [:enable, :start]
  end
end
