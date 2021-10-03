require 'spec_helper'

describe 'codenamephp_docker::compose' do
  platform 'debian' # https://github.com/chefspec/chefspec/issues/953

  step_into :codenamephp_docker_compose2

  stubs_for_provider('codenamephp_docker_compose2[Install docker compose]') do |provider|
    allow(provider).to receive_shell_out()
    allow(provider).to receive_shell_out('uname -s', stdout: 'somedist')
    allow(provider).to receive_shell_out('uname -m', stdout: 'somearch')
    allow(provider).to receive_shell_out("docker-compose -v | grep version | awk -F'[ ,]+' '{print $3}'", stdout: 'someversion')
  end

  context 'When all attributes are default' do
    recipe do
      codenamephp_docker_compose2 'Install docker compose'
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'downloads docker compose' do
      expect(chef_run).to create_remote_file('download docker compose').with(
        source: 'https://github.com/docker/compose/releases/latest/download/docker-compose-somedist-somearch',
        path: '/usr/local/lib/docker/cli-plugins/docker-compose',
        owner: 'root',
        group: 'root',
        mode: '0755'
      )
    end
  end

  context 'With custom version' do
    recipe do
      codenamephp_docker_compose2 'Install docker compose' do
        version 'someversion'
      end
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'downloads docker compose' do
      expect(chef_run).to create_remote_file('download docker compose').with(
        source: 'https://github.com/docker/compose/releases/download/someversion/docker-compose-somedist-somearch',
        path: '/usr/local/lib/docker/cli-plugins/docker-compose',
        owner: 'root',
        group: 'root',
        mode: '0755'
      )
    end
  end
end
