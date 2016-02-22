describe file(ENV['Samtools_DIR']) do
  it { should be_directory }
end

describe file(ENV['SAMTOOLS']) do
  it { should be_directory }
end

file_path = ENV['Samtools_DIR'] + '/samtools'

describe file(file_path) do
  it { should be_file }
  it { should be_executable }
end

# The early version of 0.1.17 has version in the stderr, where recent versions
# use --version to stdout
if ENV['Samtools_VERSION'] == '0.1.17'
  describe command(". /etc/profile; #{file_path}") do
    its(:stderr) { should contain('Version: ' + ENV['Samtools_VERSION']) }
  end
else
  describe command(". /etc/profile; #{file_path} --version") do
    its(:stdout) { should contain('samtools ' + ENV['Samtools_VERSION']) }
  end
end

describe command('. /etc/profile; which samtools') do
  its(:exit_status) { should eq 0 }
end
