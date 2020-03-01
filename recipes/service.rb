# frozen_string_literal: true

#
# Cookbook:: codenamephp_docker
# Recipe:: service
#
# Copyright:: 2017, The Authors, All Rights Reserved.

docker_service 'default' do
  action %i[create start]
end
