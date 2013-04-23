#!/bin/bash

appName=$1

echo "Creating emberjs project named $appName"
mkdir $appName

echo "Downloading the emberjs starter-kit"
curl -L -s -k --progress-bar https://github.com/emberjs/starter-kit/archive/master.zip -o starter-kit.zip
unzip starter-kit.zip
mv starter-kit-master/* $appName/
rm -rf starter-kit*

echo "Project has successfully been created"