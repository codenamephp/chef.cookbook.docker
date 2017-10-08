#
# Cookbook:: chef.cookbook.docker
# Recipe:: compose
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'docker_compose::installation'

execute 'add bash completion' do
  command "curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"
end