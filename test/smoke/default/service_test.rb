# # encoding: utf-8

# Inspec test for recipe chef.cookbook.docker::service

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control "docker-1.0" do
  title "Install Docker"
  desc "Install Docker and make sure the docker service is running"
  
  describe service('docker') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
