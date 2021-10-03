# frozen_string_literal: true

unified_mode true

deprecated 'The codenamephp_docker_compose resource is deprecated since doocker compose is now a part of the Docker CLI. Use the codenamephp_docker_compose2 resource instead.'

property :version, String, default: '1.29.2', description: 'The version of docker-compose to install, defaults to "latest"'

action :install do
  remote_file 'download docker-compose' do
    source compose_url
    path '/usr/local/bin/docker-compose'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  directory 'create bash completion directory' do
    path '/etc/bash_completion.d'
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
    action :create
  end

  remote_file 'download bash completion' do
    source lazy { compose_bash_completion_url }
    path '/etc/bash_completion.d/docker-compose'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end

action :uninstall do
  file '/user/local/bin/docker-compose' do
    action :delete
  end

  file '/etc/bash_completion.d/docker-compose' do
    action :delete
  end
end

action_class do
  def compose_url
    distro = shell_out('uname -s').stdout.strip
    arch = shell_out('uname -m').stdout.strip
    file = "docker-compose-#{distro}-#{arch}"

    "https://github.com/docker/compose/releases/download/#{new_resource.version}/#{file}"
  end

  def compose_bash_completion_url
    version = shell_out("docker-compose -v | grep version | awk -F'[ ,]+' '{print $3}'").stdout.strip
    "https://raw.githubusercontent.com/docker/compose/#{version}/contrib/completion/bash/docker-compose"
  end
end
