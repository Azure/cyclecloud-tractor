# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

default['tractor']['version'] = '2.2'
default['tractor']['pkg'] = 'Tractor-2.2_1715407-linuxRHEL6_gcc44icc150.x86_64.rpm'

# Configure license server location
default['tractor']['license_server']['address'] = nil
default['tractor']['license_server']['port'] = 9010

# Allow use of an engine outside this cluster
default['tractor']['engine']['address'] = nil
default['tractor']['engine']['port'] = 80

# Allow configuring/overriding generic tractor configs
default['tractor']['blade']['cmd_options'] = ''
default['tractor']['blade']['config'] = {}
default['tractor']['blade']['overrides'] = {}
default['tractor']['engine']['cmd_options'] = ''
default['tractor']['engine']['config'] = {}



default['tractor']['user']['name'] = 'tractor'
default['tractor']['user']['uid'] = '47855'
default['tractor']['is_engine'] = node.recipe?('tractor::engine')
default['tractor']['data_dir'] = '/var/spool/tractor'
default['tractor']['config_dir'] = "#{node['tractor']['data_dir']}/config"
default['tractor']['home'] = "/opt/pixar/Tractor-#{node['tractor']['version']}"


