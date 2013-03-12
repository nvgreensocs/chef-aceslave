
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
  for i in #{node[:prefix]}/bash.profile.d/*; do . $i; done

#this should read in the global profile stuff
# need to specify branch
    git clone git://projects.greensocs.com/models/aceslave.git #{node[:prefix]}/ModelLibrary/ACESlave
  EOH
  creates "#{node[:prefix]}/ModelLibrary/ACESlave"
end

bash "Update ACESlave" do
  code <<-EOH
  for i in #{node[:prefix]}/bash.profile.d/*; do . $i; done

    cd #{node[:prefix]}/ModelLibrary/ACESlave
    git pull origin master
    git reset --hard $version_aceslave

  EOH
end



bash "Compile ACESlave" do
  code <<-EOH
  for i in #{node[:prefix]}/bash.profile.d/*; do . $i; done

       cd #{node[:prefix]}/ModelLibrary/ACESlave
#       scons NOTHING TO DO - HEADER ONLY
	   
     EOH
#  creates "#{node[:prefix]}/ModelLibrary/ACESlave/lib/ACESlave.so"
end


