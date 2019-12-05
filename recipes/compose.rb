# frozen_string_literal: true

#
# Cookbook:: chef.cookbook.docker
# Recipe:: compose
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'docker_compose::installation'

directory 'create bash directory' do
  path '/etc/bash_completion.d'
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

remote_file 'download bash completion' do
  source lazy {
    "https://raw.githubusercontent.com/docker/compose/#{Mixlib::ShellOut.new("docker-compose --version | awk 'NR==1{print $NF}'").run_command.stdout.strip}/contrib/completion/bash/docker-compose"
  }
  path '/etc/bash_completion.d/docker-compose'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
