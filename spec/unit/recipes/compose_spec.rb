# frozen_string_literal: true

#
# Cookbook:: codenamephp_docker
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'codenamephp_docker::compose' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    before(:each) do
      allow_any_instance_of(Mixlib::ShellOut).to receive_message_chain(:run_command, :stdout).and_return('some version')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'includes the `docker_compose::installation` recipe' do
      expect(chef_run).to include_recipe('docker_compose::installation')
    end

    it 'creates the bash autocomplete directory if not exists ' do
      expect(chef_run).to create_directory('create bash directory').with(
        path: '/etc/bash_completion.d',
        owner: 'root',
        group: 'root',
        mode: '0755',
        recursive: true
      )
    end

    it 'downloads the autocompletion for the actual version into the bash folder' do
      expect(chef_run).to create_remote_file('download bash completion').with(
        source: 'https://raw.githubusercontent.com/docker/compose/some version/contrib/completion/bash/docker-compose',
        path: '/etc/bash_completion.d/docker-compose',
        owner: 'root',
        group: 'root',
        mode: '0755'
      )
    end
  end
end
