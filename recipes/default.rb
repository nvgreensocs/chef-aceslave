
#  -------    CHEF-ACESLAVE  --------

# LICENSETEXT
# 
#   Copyright (C) 2012 : GreenSocs Ltd
#       http://www.greensocs.com/ , email: info@greensocs.com
# 
# The contents of this file are subject to the licensing terms specified
# in the file LICENSE. Please consult this file for restrictions and
# limitations that may apply.
# 
# ENDLICENSETEXT

#add this to your versions scrip
#package "scons"

ENV['http_proxy'] = Chef::Config[:http_proxy]

directory "#{node[:prefix]}/ModelLibrary/greensocs" do
  action :create
  recursive true
end

bash "Create ACESlave" do
  code <<-EOH
#this should read in the global profile stuff
# need to specify branch
    git clone git://projects.greensocs.com/models/aceslave.git #{node[:prefix]}/ModelLibrary/ACESlave
  EOH
  creates "#{node[:prefix]}/ModelLibrary/ACESlave"
  if Chef::Config[:http_proxy]
    environment ({ 'http_proxy' => Chef::Config[:http_proxy] })
    environment ({ 'GIT_PROXY_COMMAND' => "/tmp/gitproxy" })
  end
end

bash "Update ACESlave" do
  code <<-EOH
    cd #{node[:prefix]}/ModelLibrary/ACESlave
    git pull origin master
  EOH
  if Chef::Config[:http_proxy]
    environment ({ 'http_proxy' => Chef::Config[:http_proxy] })
    environment ({ 'GIT_PROXY_COMMAND' => "/tmp/gitproxy" })
  end
end



bash "Compile ACESlave" do
  code <<-EOH
       cd #{node[:prefix]}/ModelLibrary/ACESlave
#       scons NOTHING TO DO - HEADER ONLY
	   
     EOH
#  creates "#{node[:prefix]}/ModelLibrary/ACESlave/lib/ACESlave.so"
end


