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
    source lazy {
      "https://raw.githubusercontent.com/docker/compose/#{Mixlib::ShellOut.new("docker-compose --version | awk 'NR==1{print $NF}'").run_command.stdout.strip}/contrib/completion/bash/docker-compose"
    }
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
end
