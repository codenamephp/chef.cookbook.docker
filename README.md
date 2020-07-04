# Chef Cookbook Docker

The default cookbook installs docker, makes sure the docker service is running.

This is just a wrapper cookbook for [docker][docker-github]

## Requirements

### Supported Platforms

- Debian Buster

### Chef

- Chef 13.1+

### Cookbook Depdendencies

- [docker][docker-github]

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
- `install`(default): Installs docker and creates and starts the service

[docker-github]: https://github.com/chef-cookbooks/docker