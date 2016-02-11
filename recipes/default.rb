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
magic_shell_environment 'Samtools_VERSION' do
  value node['Samtools']['version']
end

samtools_dir = node['Samtools']['install_path'] + '/' + 'samtools-' + node['Samtools']['version']
samtools_filename = "samtools-#{node['Samtools']['version']}.tar.bz2"
samtools_url = "http://sourceforge.net/projects/samtools/files/samtools/#{node['Samtools']['version']}/#{samtools_filename}"

magic_shell_environment 'Samtools_DIR' do
  value samtools_dir
end

remote_file "#{Chef::Config[:file_cache_path]}/#{samtools_filename}" do
  source samtools_url
  action :create_if_missing
end

execute 'un-tar Samtools tar ball' do
  command "tar jxvf #{Chef::Config[:file_cache_path]}/#{samtools_filename} -C #{node['Samtools']['install_path']}"
  not_if { ::File.exist?("#{samtools_dir}/README") }
end

execute 'make Samtools' do
  command 'make'
  cwd samtools_dir
  not_if { ::File.exist?("#{samtools_dir}/samtools") }
end

# this symlinks every executable in the install subdirectory to /usr/local/bin
# so that they are in the PATH
execute "find #{samtools_dir} -maxdepth 2 -executable -type f -exec ln -s {} /usr/local/bin \\;" do
  cwd node['Samtools']['install_path']
end
