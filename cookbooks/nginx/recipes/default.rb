#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Run apt-get update

execute "update apt-get database" do
	command "apt-get update"
end

#install nginx
package "nginx" do
	action:install
end

#enable nginx
service "nginx" do
	action [:start, :enable]
end


#add apache file to server

cookbook_file "/usr/share/nginx/html/index.html" do
	source "index.html"
	mode "0644"
end
