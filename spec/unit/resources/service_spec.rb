# frozen_string_literal: true

#
# Cookbook:: codenamephp_docker
# Spec:: codenamephp_docker_service
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'codenamephp_docker_service' do
  platform 'debian' # https://github.com/chefspec/chefspec/issues/953

  step_into :codenamephp_docker_service

  context 'When all attributes are default' do
    recipe do
      codenamephp_docker_service 'Install docker'
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates and starts docker service using resource' do
      expect(chef_run).to create_docker_service('default')
      expect(chef_run).to start_docker_service('default')
    end
  end

  context 'With custom dns' do
    recipe do
      codenamephp_docker_service 'Install docker' do
        dns %w(some dns)
      end
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates and starts docker service using resource' do
      expect(chef_run).to create_docker_service('default').with(dns: %w(some dns))
      expect(chef_run).to start_docker_service('default')
    end
  end
end
