#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

chef_gem "ruby-shadow" do
  action :install
end

group "barista" do
  action :create
end

user "barista" do
  gid "barista"
  home "/home/barista"
  supports :manage_home => true
  shell "/bin/zsh"
  password "$6$5KuvwfrkVLw0Bw$p3g9cLN/4qaSYuGzbU0UVwvArExvvN6czJxh2Q/dUkx.JzbWrW85nOpCn7QS9r7gIFw1kg4HpRctnjBR6xLVf."
  action [:remove, :create]
end


#
# user "barista" do
#   supports :manage_home => true
#   comment "barista"
#   gid "barista"
#   home "/home/barista"
#   shell "/bin/bash"
#   password "bobby"
#   action :create
# end
