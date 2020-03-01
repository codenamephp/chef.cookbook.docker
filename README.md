# Chef Cookbook Docker

The default cookbook installs docker, makes sure the docker service is running and installs docker compose.

This is jsut a wrapper cookbook for [docker][docker-github] and [docker_compose][docker-compose-github]

## Requirements

### Supported Platforms

- Debian Buster

### Chef

- Chef 13.1+

### Cookbook Depdendencies

- [docker][docker-github]
- [docker_compose][docker-compose-github]

## Usage

Add the cookbook to your Berksfile:

```ruby
cookbook 'codenamephp_docker', :github 'codenamephp/codenamephp_docker'
```

Add the cookbook to your runlist, e.g. in a role:

```json
{
  "name": "default",
  "chef_type": "role",
  "json_class": "Chef::Role",
  "run_list": [
	  "recipe[codenamephp_docker]"
  ]
}
```

[docker-github]: https://github.com/chef-cookbooks/docker
[docker-compose-github]: https://github.com/sboschert/chef-cookbook-docker_compose