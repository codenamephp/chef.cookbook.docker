# frozen_string_literal: true

# Inspec test for recipe codenamephp_docker::service

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe service('docker') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe command('systemctl status docker') do
  its('stdout') { should include('--dns=8.8.8.8 --dns=8.8.4.4') }
end
