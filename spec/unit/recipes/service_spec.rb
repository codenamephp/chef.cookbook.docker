# frozen_string_literal: true

#
# Cookbook:: codenamephp_docker
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'codenamephp_docker::service' do
  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'docker_service[default]' do
      expect(chef_run).to create_docker_service('default')
      expect(chef_run).to start_docker_service('default')
    end
  end
end
