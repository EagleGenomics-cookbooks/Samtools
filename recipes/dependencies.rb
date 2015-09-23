#
# Cookbook Name:: Samtools
# Recipe:: dependencies
#
# Copyright (c) 2015 Eagle Genomics, All Rights Reserved.

package ['ncurses-devel'] do
  action :install
end

package ['zlib-devel'] do
  action :install
end

include_recipe 'build-essential'
