#
# Cookbook Name:: Samtools
# Recipe:: source
#
# Copyright (c) 2016 Eagle Genomics Ltd, Apache License, Version 2.0.

##########################################################

package ['ncurses-devel', 'zlib-devel', 'tar', 'bzip2'] do
  action :install
end

include_recipe 'build-essential'

# here for use by serverspec
magic_shell_environment 'Samtools_DIR' do
  value node['Samtools']['dir']
end

magic_shell_environment 'Samtools_VERSION' do
  value node['Samtools']['version']
end

magic_shell_environment 'Samtools_INSTALL' do
  value node['Samtools']['install']
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node['Samtools']['filename']}" do
  source node['Samtools']['url']
  action :create_if_missing
end

execute 'un-tar Samtools tar ball' do
  command "tar jxvf #{Chef::Config[:file_cache_path]}/#{node['Samtools']['filename']} -C #{node['Samtools']['install_path']}"
  not_if { ::File.exist?("#{node['Samtools']['dir']}/README") }
end

execute 'Samtools make' do
  command 'make'
  cwd node['Samtools']['dir']
  not_if { ::File.exist?("#{node['Samtools']['dir']}/src/samtools") }
end

execute 'Samtools make install' do
  command 'make install'
  cwd node['Samtools']['dir']
  not_if { ::File.exist?("#{node['Samtools']['install_dir']}/bin/samtools") }
end

# this symlinks every executable in the install subdirectory to the top of the directory tree
# so that they are in the PATH
execute "find #{node['Samtools']['dir']} -maxdepth 1 -name 'sam*' -executable -type f -exec ln -s {} . \\;" do
  cwd node['Samtools']['install']
end

##########################################################
##########################################################
