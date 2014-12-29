package "build-essential"

execute "get install script" do
  command "cd /tmp; wget https://raw.githubusercontent.com/jayrambhia/Install-OpenCV/master/Ubuntu/opencv_install.sh; chmod +x /tmp/opencv_install.sh"
  not_if "ls /tmp/opencv_install.sh"
end

execute "install OpenCV" do
  command "/tmp/opencv_install.sh"
  not_if "which opencv_createsamples"
end
