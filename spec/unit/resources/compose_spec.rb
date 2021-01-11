# frozen_string_literal: true

#
# Cookbook:: codenamephp_docker
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'codenamephp_docker::compose' do
  platform 'debian' # https://github.com/chefspec/chefspec/issues/953

  step_into :codenamephp_docker_compose

  stubs_for_provider('codenamephp_docker_compose[Install docker-compose]') do |provider|
    allow(provider).to receive_shell_out()
    allow(provider).to receive_shell_out('uname -s', stdout: 'somedist')
    allow(provider).to receive_shell_out('uname -m', stdout: 'somearch')
    allow(provider).to receive_shell_out("docker-compose -v | grep version | awk -F'[ ,]+' '{print $3}'", stdout: 'someversion')
  end

  context 'When all attributes are default' do
    recipe do
      codenamephp_docker_compose 'Install docker-compose'
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'downloads docker-compose' do
      expect(chef_run).to create_remote_file('download docker-compose').with(
        source: 'https://github.com/docker/compose/releases/latest/download/docker-compose-somedist-somearch',
        path: '/usr/local/bin/docker-compose',
        owner: 'root',
        group: 'root',
        mode: '0755'
      )
    end

    it 'creates the bash autocomplete directory if not exists ' do
      expect(chef_run).to create_directory('create bash completion directory').with(
        path: '/etc/bash_completion.d',
        owner: 'root',
        group: 'root',
        mode: '0755',
        recursive: true
      )
    end

    it 'downloads the autocompletion for the actual version into the bash folder' do
      expect(chef_run).to create_remote_file('download bash completion').with(
        source: 'https://raw.githubusercontent.com/docker/compose/someversion/contrib/completion/bash/docker-compose',
        path: '/etc/bash_completion.d/docker-compose',
        owner: 'root',
        group: 'root',
        mode: '0755'
      )
    end
  end

  context 'With custom version' do
    recipe do
      codenamephp_docker_compose 'Install docker-compose' do
        version 'someversion'
      end
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'downloads docker-compose' do
      expect(chef_run).to create_remote_file('download docker-compose').with(
        source: 'https://github.com/docker/compose/releases/download/someversion/docker-compose-somedist-somearch',
        path: '/usr/local/bin/docker-compose',
        owner: 'root',
        group: 'root',
        mode: '0755'
      )
    end
  end
end
