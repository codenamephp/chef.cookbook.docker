# frozen_string_literal: true

name 'codenamephp_docker'
maintainer 'Bastian Schwarz'
maintainer_email 'bastian@codename-php.de'
license 'Apache-2.0'
description 'Installs/Configures codenamephp_docker'
version '1.1.0'
chef_version '>= 13.0' if respond_to?(:chef_version)
issues_url 'https://github.com/codenamephp/chef.cookbook.docker/issues'
source_url 'https://github.com/codenamephp/chef.cookbook.docker'

supports 'debian'

depends 'docker', '~> 6.0'
