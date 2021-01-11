# frozen_string_literal: true
property :dns, [String, Array], default: ['8.8.8.8', '8.8.4.4'], description: 'DNS settings to pass to the service configuration'

action :install do
  docker_service 'default' do
    action %i(create start)
    dns new_resource.dns
  end
end
