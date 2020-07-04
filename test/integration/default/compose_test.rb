# frozen_string_literal: true

describe command('sudo docker-compose -v') do
  its('stdout') { should match(/docker-compose version/) }
end
