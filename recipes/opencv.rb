package "unzip"
package "libopencv-dev"
package "build-essential"
package "checkinstall"
package "cmake"
package "pkg-config"
package "yasm"
package "libjpeg-dev"
package "libjasper-dev"
package "libavcodec-dev"
package "libavformat-dev"
package "libswscale-dev"
package "libdc1394-22-dev"
package "libxine-dev"
package "libgstreamer0.10-dev"
package "libgstreamer-plugins-base0.10-dev"
package "libv4l-dev"
package "python-dev"
package "python-numpy"
package "libtbb-dev"
package "libqt4-dev"
package "libgtk2.0-dev"
package "libfaac-dev"
package "libmp3lame-dev"
package "libopencore-amrnb-dev"
package "libopencore-amrwb-dev"
package "libtheora-dev"
package "libvorbis-dev"
package "libxvidcore-dev"
package "x264"
package "v4l-utils"
#package "ffmpeg"

VERSION = "2.4.10"
WORKING_DIR = "/usr/local/src/opencv"
CMAKE_OPT = "-D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON .."

execute "get opencv zip file" do
  command "mkdir #{WORKING_DIR}; cd #{WORKING_DIR}; wget -O OpenCV-#{VERSION}.zip http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/#{VERSION}/opencv-#{VERSION}.zip/download"
  not_if "test -e #{WORKING_DIR}/OpenCV-#{VERSION}.zip"
end

execute "prepare make" do
  command "cd #{WORKING_DIR}; unzip OpenCV-#{VERSION}.zip; cd opencv-#{VERSION}; mkdir build"
  not_if "test -e #{WORKING_DIR}/opencv-#{VERSION}"
end

execute "make opencv" do
  command "cd #{WORKING_DIR}/opencv-#{VERSION}/build; cmake #{CMAKE_OPT}; make -j2"
end

execute "set ldconfig" do
  command "echo '/usr/local/lib' > /etc/ld.so.conf.d/opencv.conf; ldconfig"
end

