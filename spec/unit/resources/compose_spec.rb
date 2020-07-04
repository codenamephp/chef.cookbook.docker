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
      allow(Mixlib::ShellOut).to receive(:new).and_call_original
      allow(Mixlib::ShellOut).to receive(:new).with('uname -s').and_return(double(run_command: double(stdout: 'somedist')))
      allow(Mixlib::ShellOut).to receive(:new).with('uname -m').and_return(double(run_command: double(stdout: 'somearch')))
      allow(Mixlib::ShellOut).to receive(:new).with("docker-compose -v | grep version | awk -F'[ ,]+' '{print $3}'").and_return(double(run_command: double(stdout: 'someversion')))
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

    before(:each) do
      allow(Mixlib::ShellOut).to receive(:new).and_call_original
      allow(Mixlib::ShellOut).to receive(:new).with('uname -s').and_return(double(run_command: double(stdout: 'somedist')))
      allow(Mixlib::ShellOut).to receive(:new).with('uname -m').and_return(double(run_command: double(stdout: 'somearch')))
      allow(Mixlib::ShellOut).to receive(:new).with("docker-compose -v | grep version | awk -F'[ ,]+' '{print $3}'").and_return(double(run_command: double(stdout: 'someversion')))
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
