#
# Cookbook:: tractor
# Recipe:: engine
#
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

include_recipe "tractor::default"

tractor_user = node['tractor']['user']['name']
tractor_home = node['tractor']['home']

directory node['tractor']['config_dir'] do
  recursive true
  owner tractor_user
  group tractor_user
  mode 0755
  recursive true
end


bash "copy default tractor config files" do
  code <<-EOH
  cp #{tractor_home}/config/*  #{node['tractor']['config_dir']}/ && chown -R #{tractor_user}:#{tractor_user} #{node['tractor']['config_dir']}
  EOH
  creates "#{node['tractor']['config_dir']}/tractor.config"
end



# Setup Engine service
template "/etc/sysconfig/tractor-engine" do
  source "tractor-engine.erb"
end

template "#{node['tractor']['config_dir']}/tractor.config" do
  source "tractor.config.erb"
end

bash "create Engine service" do
  code <<-EOH
  cp #{tractor_home}/lib/SystemServices/systemd/tractor-engine.service  /usr/lib/systemd/system/tractor-engine.service
  EOH
  creates '/usr/lib/systemd/system/tractor-engine.service'
end




service 'tractor-engine' do
  action [:enable, :start]
end
