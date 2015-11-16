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

describe command("#{file_path} --version") do
  its(:stdout) { should contain("samtools " + ENV['Samtools_VERSION']) }
end

describe command("which samtools") do
  its(:exit_status) { should eq 0 }
end
