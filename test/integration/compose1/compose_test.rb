# frozen_string_literal: true

describe command('docker-compose -v') do
  its('stdout') { should match(/docker-compose version/) }
end

describe command("docker-compose -v | grep version | awk -F'[ ,]+' '{print $3}'") do
  its('stdout') { should cmp < '2.0.0' }
end
