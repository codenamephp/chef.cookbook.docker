# frozen_string_literal: true

include_recipe 'resolver'
codenamephp_docker_service 'Install docker'

codenamephp_docker_compose 'Install docker-compose'
