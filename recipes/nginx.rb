package "nginx"
package "apache2-utils"

execute "backup old file" do
  command "cp -p /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old"
end

execute "remove default file" do
  command "rm /etc/nginx/sites-enabled/default"
  only_if "test -e /etc/nginx/sites-enabled/default"
end

template "/etc/nginx/nginx.conf" do
  source "template/nginx.conf.erb"
end

template "/etc/nginx/sites-enabled/site" do
  source "template/site.conf.erb"
end

service "nginx" do
  action [:enable, :restart]
end
