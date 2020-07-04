# frozen_string_literal: true

property :version, String, default: 'latest', description: 'The version of docker-compose to install, defaults to "latest"'

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

action_class do
  def compose_url
    new_resource.version == 'latest' ? 'https://github.com/docker/compose/releases/latest/download/run.sh' : "https://github.com/docker/compose/releases/download/#{new_resource.version}/run.sh"
  end

  def compose_bash_completion_url
    version = Mixlib::ShellOut.new("docker-compose -v | grep version | awk -F'[ ,]+' '{print $3}'").run_command.stdout.strip
    "https://raw.githubusercontent.com/docker/compose/#{version}/contrib/completion/bash/docker-compose"
  end
end
