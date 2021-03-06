name 'Samtools'
maintainer 'Eagle Genomics'
maintainer_email 'chef@eaglegenomics.com'
license 'Apache v2.0'
description 'Installs/Configures Samtools'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.4'

supports 'centos', '= 6.6'
supports 'ubuntu', '= 14.04'

depends 'build-essential'
depends 'magic_shell'
