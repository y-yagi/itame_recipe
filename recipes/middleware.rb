package "nginx"

execute "install package necessary for imagemagick" do
  command "apt-get build-dep imagemagick -y"
end

package "imagemagick"

