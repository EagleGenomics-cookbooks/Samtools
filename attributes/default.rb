# 'master' can be used for the current version
default['Samtools']['version'] = '1.2'
default['Samtools']['install_path'] = '/usr/local/bin'
default['Samtools']['dir'] = default['Samtools']['install_path'] + '/' + 'samtools-' + default['Samtools']['version']
default['Samtools']['filename'] = "samtools-#{node['Samtools']['version']}.tar.bz2"
default['Samtools']['url'] = "http://sourceforge.net/projects/samtools/files/samtools/#{node['Samtools']['version']}/#{node['Samtools']['filename']}"
