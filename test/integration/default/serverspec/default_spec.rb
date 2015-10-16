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
