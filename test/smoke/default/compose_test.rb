# frozen_string_literal: true

# Inspec test for recipe chef.cookbook.docker::compose

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'docker-compose-1.0' do
  title 'Install Docker Compose'
  desc 'Install Docker Compose'

  describe command('sudo docker-compose -v') do
    its('stdout') { should match(/docker-compose version/) }
  end
end
