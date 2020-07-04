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

  context 'When all attributes are default' do
    recipe do
      codenamephp_docker_compose 'Install docker-compose'
    end

    before(:each) do
      allow_any_instance_of(Mixlib::ShellOut).to receive_message_chain(:run_command, :stdout).and_return('someversion')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'downloads docker-compose' do
      expect(chef_run).to create_remote_file('download docker-compose').with(
        source: 'https://github.com/docker/compose/releases/latest/download/run.sh',
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
        source: 'https://github.com/docker/compose/releases/download/someversion/run.sh',
        path: '/usr/local/bin/docker-compose',
        owner: 'root',
        group: 'root',
        mode: '0755'
      )
    end
  end
end
