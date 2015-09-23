require 'serverspec'
require_relative './spec_helper'

# Required by serverspec
set :backend, :exec

describe file(ENV['Samtools_DIR']) do
  it { should be_directory }
end

file_path = ENV['Samtools_DIR'] + '/samtools'
describe file(file_path) do
  it { should be_file }
  it { should be_executable }
end

# describe command('rsem-bam2readdepth') do
#   its(:stdout) { should contain('Usage: ') }
# end

# describe command('rsem-tbam2gbam') do
#   its(:stdout) { should contain('Usage: ') }
# end

# describe command('rsem-prepare-reference') do
#   its(:stderr) { should contain('Invalid number of arguments') }
# end
