# frozen_string_literal: true

action :install do
  docker_service 'default' do
    action %i(create start)
  end
end
