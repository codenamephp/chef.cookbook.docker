# frozen_string_literal: true

name 'codenamephp_docker'
maintainer 'Bastian Schwarz'
maintainer_email 'bastian@codename-php.de'
license 'Apache-2.0'
description 'Installs/Configures codenamephp_docker'
version '3.4.0'
chef_version '>= 15.3'
issues_url 'https://github.com/codenamephp/chef.cookbook.docker/issues'
source_url 'https://github.com/codenamephp/chef.cookbook.docker'

supports 'debian'

depends 'docker', '~> 9.7'
