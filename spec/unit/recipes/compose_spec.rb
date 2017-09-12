#
# Cookbook:: chef.cookbook.docker
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'chef.cookbook.docker::compose' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    
    it 'includes the `docker_compose::installation` recipe' do
      expect(chef_run).to include_recipe('docker_compose::installation')
    end
    
    it 'runs a execute with the default action' do
      expect(chef_run).to run_execute('add bash completion')
    end
  end
end
