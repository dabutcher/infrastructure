#
# Cookbook Name:: backuppc
# Recipe:: server
#
# Copyright 2012, Michael Paul Thomas Conigliaro
#
include_recipe "apache"

package "backuppc"

service "backuppc" do
  action :enable
end

group "backuppc" do
  members node["backuppc"]["users"]
  append true
end

template "/etc/backuppc/config.pl" do
  source "config.pl.erb"
  mode "0644"
  owner "backuppc"
  group "www-data"
  notifies :restart, "service[backuppc]"
end

template "/etc/backuppc/hosts" do
  source "hosts.erb"
  mode "0644"
  owner "backuppc"
  group "www-data"
  notifies :restart, "service[backuppc]"
end

node["backuppc"]["hosts"].each do |host,opts|
  file "/etc/backuppc/#{host}.pl" do
    content opts.sort.map { |name,value| "$Conf{#{name}} = #{value};" }.join("\n")
    mode "0644"
    owner "backuppc"
    group "www-data"
    notifies :restart, "service[backuppc]"
  end
end

directory "/var/lib/backuppc" do
  owner "backuppc"
  group "www-data"
end

ssh_key_path = "/var/lib/backuppc/.ssh/id_rsa"
execute "ssh-keygen -f #{ssh_key_path} -N ''" do
  user "backuppc"
  not_if { File.exists?(ssh_key_path) }
end

template "/var/lib/backuppc/.ssh/config" do
  source "config.erb"
  mode "0644"
  owner "backuppc"
  group "www-data"
end

template "/etc/backuppc/apache.conf" do
  source "apache.conf.erb"
  mode "0644"
  owner "backuppc"
  group "www-data"
  notifies :restart, "service[apache2]"
end

link "/etc/apache2/conf.d/backuppc" do
  to "/etc/backuppc/apache.conf"
  notifies :restart, "service[apache2]"
end

template "/etc/monit/conf.d/backuppc.monit" do
  source "backuppc.monit.erb"
  mode "0644"
  notifies :restart, "service[monit]"
end
