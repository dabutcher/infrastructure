#
# Cookbook Name:: deluge
# Recipe:: deluged
#
# Copyright 2012, Michael Paul Thomas Conigliaro
#
package "deluged"

service "deluged"

# FIXME: https://bugs.launchpad.net/ubuntu/+source/deluge/+bug/990629
template "/etc/init/deluged.conf" do
  source "deluged.conf.init.erb"
  mode "0644"
  notifies :restart, "service[deluged]"
end

link "/etc/init.d/deluged" do
  to "/lib/init/upstart-job"
end

template "/etc/monit/conf.d/deluged.monit" do
  source "deluged.monit.erb"
  mode "0644"
  notifies :restart, "service[monit]"
end
