# Chef Cookbook Docker

The default cookbook installs docker, makes sure the docker service is running.

This is just a wrapper cookbook for [docker][docker-github]

## Usage

Add the cookbook to your Berksfile:

```ruby
cookbook 'codenamephp_docker'
```

Use the resources as needed in a wrapper cookbook. You can check out some examples either in this readme or in the test/fixtures/test cookbook.

## Resources
### Service
Uses the `docker_service` resource to install docker and create and start the service.

#### Actions
- `install`: Installs docker and creates and starts the service

#### Properties
- `dns`: String or String Array of dns servers that will be used by the docker service, defaults to `['8.8.8.8', '8.8.4.4']` (google dns)

#### Examples
With minimal properties:
```ruby
# Install
codenamephp_docker_service 'Install docker'
```

With custom dns:
```ruby
# Install
codenamephp_docker_service 'Install docker' do
  dns '127.0.0.1'
end

codenamephp_docker_service 'Install docker' do
  dns ['127.0.0.1', '::1']
end
```

### Compose2
Installs docker compose cli plugin.

#### Actions
- `install`: Installs docker-compose and bash completion

#### Properties
- `version`: The desired version as string, defaults to `'latest'`

#### Examples
With minimal properties:
```ruby
# Install
codenamephp_docker_compose2 'Install docker-compose'
```

With custom version:
```ruby
codenamephp_docker_compose2 'Install docker-compose' do
  version '2.0.1'
end
```

### Compose
Installs docker-compose (v1) as a docker image using the run script wrapper from docker-compose github. The bash completion is also installed.

#### Deprecated
This resource has been deprecated and will be removed with the next major release. Use the `codenamephp_docker_compose2` resource instead.

#### Actions
- `install`: Installs docker-compose and bash completion
- `uninstall`: Uninstalls docker-compose and bash completion

#### Properties
- `version`: The desired version as string, defaults to `'latest'`

#### Examples
With minimal properties:
```ruby
# Install
codenamephp_docker_compose 'Install docker-compose'
```

With custom version:
```ruby
codenamephp_docker_compose 'Install docker-compose' do
  version '1.26.1'
end
```

[docker-github]: https://github.com/chef-cookbooks/docker
