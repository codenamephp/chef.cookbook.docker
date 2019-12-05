# frozen_string_literal: true

#
# Cookbook:: chef.cookbook.docker
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe '::service'
include_recipe '::compose'
