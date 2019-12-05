# frozen_string_literal: true

#
# Cookbook:: chef.cookbook.docker
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'chef.cookbook.docker::default' do
  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'includes the `service` recipe' do
      expect(chef_run).to include_recipe('chef.cookbook.docker::service')
    end

    it 'includes the `compose` recipe' do
      expect(chef_run).to include_recipe('chef.cookbook.docker::compose')
    end
  end
end
