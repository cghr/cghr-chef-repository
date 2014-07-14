#
# Cookbook Name:: node-sandbox
# Recipe:: default
#
# Copyright 2014, Centre for Global Health Research
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'openldap::install'

include_recipe 'trac-projects::synchronize'

node.default.trac.project.each do |project|
  project_id = project[1].id
  
  include_recipe 'trac-project-' + project_id + '::post-synchronize'
end
