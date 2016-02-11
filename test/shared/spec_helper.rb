require 'serverspec'

# Required by serverspec
set :backend, :exec

set :shell, '/bin/bash'

set :path, '/usr/local/bin/:$PATH'
