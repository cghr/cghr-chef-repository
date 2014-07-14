#
# Cookbook Name:: cghr-server-node
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'cghr-server::httpd'
include_recipe 'cghr-server::mysql'
include_recipe 'cghr-server::php'
