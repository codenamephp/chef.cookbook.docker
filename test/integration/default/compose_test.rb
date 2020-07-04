# frozen_string_literal: true

describe command('docker-compose -v') do
  its('stdout') { should match(/docker-compose version/) }
end
