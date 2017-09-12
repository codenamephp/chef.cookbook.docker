#
# Cookbook:: chef.cookbook.docker
# Recipe:: compose
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'docker_compose::installation'

execute 'add bash completion' do
  command 'sudo curl -L https://raw.githubusercontent.com/docker/compose/1.16.1/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose'
end