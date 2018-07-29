#
# Cookbook:: tractor
# Recipe:: default
#
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

include_recipe "jetpack"

tractor_user = node['tractor']['user']['name']
tractor_pkg = node['tractor']['pkg']
tractor_pkg_path = "#{node['jetpack']['downloads']}/#{tractor_pkg}"


group tractor_user do
  action :create
end

user tractor_user do
  shell '/bin/bash'
  uid node['tractor']['user']['uid']
  gid tractor_user
end

directory node['jetpack']['downloads'] do
  recursive true
end

directory node['tractor']['data_dir'] do
  recursive true
  owner tractor_user
  group tractor_user
  mode 0755
  recursive true
end

jetpack_download tractor_pkg do
  project "tractor"
  not_if { ::File.exist?(tractor_pkg_path) }
end

package tractor_pkg_path do
  action :install
end


# Add system-wide path to profile.d and configure all users with local environment home
file '/etc/profile.d/tractor-env.sh' do
  content <<-EOH
  #!/bin/bash

  export TRACTOR_HOME=#{node['tractor']['home']}
  export PATH=$PATH:#{node['tractor']['home']}/bin


  EOH
  owner 'root'
  group 'root'
  mode '0755'
end
