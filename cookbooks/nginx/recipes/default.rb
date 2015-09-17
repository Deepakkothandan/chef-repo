#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Run apt-get update
#execute "update apt-get database" do
#	command "apt-get update"
#end

#install nginx
package "nginx" do
	action :install
end

#enable nginx
service "nginx" do
	action [:start, :enable]
end

template "/etc/nginx/sites-enabled/valmano.de.conf" do
	source 'valmano.de.conf.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

#create a directory for webserver root
directory "/var/www/valmano" do
	owner "root"
	group"root"
	mode "0644"
	action :create
end

#create a directory for site.d root
directory "/etc/nginx/site.d" do
        owner "root"
        group"root"
        mode "0644"
        action :create
end

#add index file to server
cookbook_file "/var/www/valmano/index.html" do
	source "index.html"
	mode "0644"
end

#copy directory site.d

remote_directory "/etc/nginx/site.d" do
	source "site.d"
	owner "root"
	group "root"
	mode "0744"
end

remote_directory "/etc/nginx/sites-enabled" do
        source "sites-enabled"
        owner "root"
        group "root"
        mode "0744"
end

remote_directory "/etc/nginx" do
        source "etc_nginx"
        owner "root"
        group "root"
        mode "0744"
end


#restart nginx
service "nginx" do
	action :restart
end
