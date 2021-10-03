# frozen_string_literal: true

describe command('docker compose version') do
  its('stdout') { should match(/Docker Compose version/) }
end

describe command("docker compose version | grep version | awk -F'[ ,]+' '{print $4}'") do
  its('stdout') { should cmp > '2.0.0' }
end
