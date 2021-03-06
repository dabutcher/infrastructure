#
# Cookbook Name:: deluge
# Recipe:: deluge-web
#
# Copyright 2012, Michael Paul Thomas Conigliaro
#
package "deluge-web"

service "deluge-web"

# FIXME: https://bugs.launchpad.net/ubuntu/+source/deluge/+bug/990629
template "/etc/init/deluge-web.conf" do
  source "deluge-web.conf.init.erb"
  mode "0644"
  notifies :restart, "service[deluge-web]"
end

link "/etc/init.d/deluge-web" do
  to "/lib/init/upstart-job"
end

template "/etc/monit/conf.d/deluge-web.monit" do
  source "deluge-web.monit.erb"
  mode "0644"
  notifies :restart, "service[monit]"
end
