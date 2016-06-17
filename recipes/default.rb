#
# Cookbook Name:: Samtools
# Recipe:: source
#
# Copyright (c) 2016 Eagle Genomics Ltd, Apache License, Version 2.0.

##########################################################

if node['platform_family'] == 'debian'
  package ['zlib1g-dev', 'libncurses5-dev'] do
    action :install
  end
elsif node['platform_family'] == 'rhel'
  package ['zlib-devel', 'ncurses-devel'] do
    action :install
  end
end

package %w(tar bzip2) do
  action :install
end

include_recipe 'build-essential'

samtools_dir = node['Samtools']['install_path'] + '/' + 'samtools-' + node['Samtools']['version']
samtools_filename = "samtools-#{node['Samtools']['version']}.tar.bz2"
samtools_url = "http://sourceforge.net/projects/samtools/files/samtools/#{node['Samtools']['version']}/#{samtools_filename}"

remote_file "#{Chef::Config[:file_cache_path]}/#{samtools_filename}" do
  source samtools_url
  action :create_if_missing
end

execute 'un-tar Samtools tar ball' do
  command "tar jxvf #{Chef::Config[:file_cache_path]}/#{samtools_filename} -C #{node['Samtools']['install_path']}"
  not_if { ::File.exist?("#{samtools_dir}/README") }
end

execute 'make Samtools' do
  command 'make ' + node['Samtools']['make_options']
  cwd samtools_dir
  not_if { ::File.exist?("#{samtools_dir}/samtools") }
end

# this symlinks every executable in the install subdirectory to /usr/local/bin
# so that they are in the PATH
execute "find #{samtools_dir} -maxdepth 2 -executable -type f -exec ln -s {} /usr/local/bin \\;" do
  cwd node['Samtools']['install_path']
end

magic_shell_environment 'Samtools_VERSION' do
  value node['Samtools']['version']
end

magic_shell_environment 'Samtools_DIR' do
  value samtools_dir
end

# This is needed for Bio::DB:Sam
magic_shell_environment 'SAMTOOLS' do
  value samtools_dir
end
