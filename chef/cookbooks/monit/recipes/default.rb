#
# Cookbook Name:: monit
# Recipe:: default
#
# Copyright 2011, Michael Paul Thomas Conigliaro
#
package "monit"

service "monit" do
  action :enable
end

template "/etc/default/monit" do
  source "monit.default.erb"
  mode "0644"
  notifies :restart, "service[monit]"
end

template "/etc/monit/monitrc" do
  source "monitrc.erb"
  mode "0600"
  notifies :restart, "service[monit]"
end

template "/etc/monit/conf.d/system.monit" do
  source "system.monit.erb"
  mode "0644"
  notifies :restart, "service[monit]"
end

# FIXME: Temporary
cron "monit monitor all" do
  hour "*"
  minute "0"
  command "/usr/#{node[:lsb][:release] == "11.10" ? "sbin" : "bin" }/monit monitor all 2>&1 > /dev/null"
end
