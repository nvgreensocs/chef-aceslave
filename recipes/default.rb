
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
# need to specify branch
    git clone  git://git.greensocs.com/ACESlave.git #{node[:prefix]}/ModelLibrary/ACESlave
  EOH
  creates "#{node[:prefix]}/ModelLibrary/ACESlave"
  environment ({ 'http_proxy' => Chef::Config[:http_proxy] })
end

bash "Update ACESlave" do
  code <<-EOH
    cd #{node[:prefix]}/ModelLibrary/ACESlave
    git pull origin master
  EOH
  environment ({ 'http_proxy' => Chef::Config[:http_proxy] })
end



ruby_block "compile ACESlave" do
  block do
    IO.popen( <<-EOH
       cd #{node[:prefix]}/ModelLibrary/ACESlave
#       scons NOTHING TO DO - HEADER ONLY
	   
     EOH
   ) { |f|  f.each_line { |line| puts line } }
  end
#  creates "#{node[:prefix]}/ModelLibrary/ACESlave/lib/ACESlave.so"
end


