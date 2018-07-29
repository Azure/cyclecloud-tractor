name             'tractor'
description      'Installs/Configures Tractor on a CycleCloud Cluster'
version          '1.0.0'


chef_version '>= 11' if respond_to?(:chef_version)

%w{cyclecloud jetpack}.each {|c| depends c}
