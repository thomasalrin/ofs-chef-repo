#
# Cookbook Name:: mvp
# Recipe:: default
#
# Copyright 2016, OFS Technologies
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apt"
include_recipe "stackstorm"
include_recipe "jenkins"
include_recipe "petclinic_project_integration"
include_recipe "selenium_test"
include_recipe "docker_installation"
