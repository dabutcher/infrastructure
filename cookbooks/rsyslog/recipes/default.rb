#
# Cookbook Name:: rsyslog
# Recipe:: default
#
# Copyright 2012, Michael Paul Thomas Conigliaro
#
package "rsyslog"

service "rsyslog"

template "/etc/monit/conf.d/rsyslog.monit" do
  source "rsyslog.monit.erb"
  mode "0644"
  notifies :restart, "service[monit]"
end
