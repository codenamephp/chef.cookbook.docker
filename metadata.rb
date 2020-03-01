# frozen_string_literal: true

name 'codenamephp_docker'
maintainer 'Bastian Schwarz'
maintainer_email 'bastian@codename-php.de'
license 'Apache-2.0'
description 'Installs/Configures codenamephp_docker'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
long_description 'Installs/Configures chef.cookbook.docker'
version '1.0.1'
chef_version '>= 13.0' if respond_to?(:chef_version)
issues_url 'https://github.com/codenamephp/chef.cookbook.ci.jenkins/issues' if respond_to?(:issues_url)
source_url 'https://github.com/codenamephp/chef.cookbook.ci.jenkins' if respond_to?(:source_url)

supports 'debian', '~>10.0'

depends 'docker', '~> 4.10'
depends 'docker_compose', '~> 0.1'
