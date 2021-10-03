unified_mode true

property :version, String, default: 'latest', description: 'The version of docker compose to install, defaults to "latest"'

action :install do
  directory '/usr/local/lib/docker/cli-plugins' do
    recursive true
    owner 'root'
    group 'root'
  end

  remote_file 'download docker compose' do
    source compose_url
    path '/usr/local/lib/docker/cli-plugins/docker-compose'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end

action_class do
  def compose_url
    distro = shell_out('uname -s').stdout.strip
    arch = shell_out('uname -m').stdout.strip
    file = "docker-compose-#{distro}-#{arch}"

    new_resource.version == 'latest' ? "https://github.com/docker/compose/releases/latest/download/#{file}" : "https://github.com/docker/compose/releases/download/#{new_resource.version}/#{file}"
  end
end
