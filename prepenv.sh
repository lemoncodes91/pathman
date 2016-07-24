#!/bin/sh


echo "Preparing Environment!..."

echo "Installing bzip archive rpm!... "

yum -y install gcc gcc-c++ make flex bison gperf ruby \
  openssl-devel freetype-devel fontconfig-devel libicu-devel sqlite-devel \
  libpng-devel libjpeg-devel bzip2 bzip2-libs

echo "==> Execution status: $?"

echo "Installing Git..."
yum -y install git

echo "==> Execution status: $?"

echo "Installing SVN... "
yum -y install svn

echo "==> Execution status: $?"

echo "Installing NodeJS (npm)... "
echo "===================================="
echo "* Please select version            *"
echo "* 1: 4.x (stable)                  *"
echo "* 2: 6.x (current dev)             *"
echo "* 3: 0.10 (legacy)                 *"
echo "==================================="
echo "Entery Choice: "
read RESPONSE

case "$RESPONSE" in

1)
 echo "Installation NodeJS 4.x"
 curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -
 ;;
2)
 echo "Installation NodeJS 6.x"
 curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
 ;;
*) 
 echo "Installation NodeJS 0.10"
 curl --silent --location https://rpm.nodesource.com/setup | bash -
 ;;

esac

yum -y install nodejs


echo "Starting post installation.. "

echo "Setting ENV variables "

if [ `npm config get prefix | grep local | wc -l` -eq 1 ]; then
  sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
else
 mkdir ~/.npm-global
 npm config set prefix '~/.npm-global'
 echo "export PATH=~/.npm-global/bin:$PATH" >> ~/.profile
 echo "source ~/.profile" >> ~/.bashrc
fi

echo 'export NODE_PATH="'$(npm root -g)'"' >> ~/.bashrc 

echo "Modifying Permissions... "
mkdir ~/.config
mkdir ~/.cache
mkdir ~/.local
chmod -R g+rw ~/.config ~/.cache ~/.local ~/.npm ~/.npm-global


echo "Post installation done!... "

echo "Installing Generator Angular... "
#npm install -g grunt-cli bower yo generator-karma generator-angular

echo "==> Execution status: $?"
